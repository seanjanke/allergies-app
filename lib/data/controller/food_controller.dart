import 'package:allergies/data/models/allergy.dart';
import 'package:allergies/data/models/food.dart';
import 'package:allergies/data/services/food_service.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FoodController extends GetxController {
  RxString userId = "".obs;
  RxList<Food> foodsList = <Food>[].obs;
  RxList<Food> scanList = <Food>[].obs;
  RxList<Allergy> allergiesList = <Allergy>[
    Allergy(allergeneType: AllergeneType.nuts),
  ].obs;
  RxBool foodAlreadyExistant = false.obs;
  RxBool allergyAlreadyExistant = false.obs;
  RxList<String> qrCodesList = <String>[].obs;
  final audioPlayer = AudioPlayer();
  Rx<Food> selectedFood = Food(
    name: RxString(""),
    allergens: [],
    traces: [],
    brand: RxString(""),
    ingredients: "",
  ).obs;

  @override
  void onInit() {
    super.onInit();
    initializeController();
  }

  Future<void> initializeController() async {
    await getUserId();
    await getAllergies();
    await getFoods();
  }

  void setUserId(String newUserId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId.value = newUserId;

    await prefs.setString('userId', newUserId);
  }

  Future<void> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String userIdPrefs = prefs.getString('userId') ?? '';
    userId.value = userIdPrefs;
  }

  void addFood(Food food) async {
    foodAlreadyExistant.value = false;

    if (userId.value.isEmpty) {
      DocumentReference docRefUser = await FirebaseFirestore.instance
          .collection('users')
          .add({'userId': ''});
      docRefUser.update({'userId': docRefUser.id});

      setUserId(docRefUser.id);
    }

    foodsList.add(food);

    DocumentReference docRef = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId.value)
        .collection('foods')
        .add({
      'id': 'id',
      'name': food.name.value,
      'timestamp': Timestamp.fromDate(food.uploadTime!),
      'brand': food.brand.value,
      'ingredients': food.ingredients,
    });

    docRef.update({'id': docRef.id});

    for (String allergy in food.allergens) {
      docRef.collection('allergies').doc(allergy).set({
        'name': allergy,
      });
    }

    for (String trace in food.traces) {
      docRef.collection('traces').doc(trace).set(
        {'name': trace},
      );
    }
  }

  Future<void> getFoods() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId.value)
          .collection('foods')
          .get();

      foodsList.clear();

      for (QueryDocumentSnapshot doc in snapshot.docs) {
        String foodName = doc['name'].toLowerCase();
        Timestamp uploadTime = doc['timestamp'];
        String brand = doc['brand'];
        DateTime uploadDateTime = uploadTime.toDate();

        QuerySnapshot snapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId.value)
            .collection('foods')
            .doc(doc.id)
            .collection('allergies')
            .get();

        QuerySnapshot tracesSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId.value)
            .collection('foods')
            .doc(doc.id)
            .collection('traces')
            .get();

        List<String> allergenesList = [];

        for (QueryDocumentSnapshot doc in snapshot.docs) {
          String allergyName = doc['name'].toLowerCase();
          allergenesList.add(allergyName);
        }

        String ingredients = "";
        if (doc['ingredients'] != null) {
          ingredients = doc['ingredients'];
        }

        List<String> tracesList = [];

        for (QueryDocumentSnapshot trace in tracesSnapshot.docs) {
          String traceName = trace['name'].toLowerCase();
          tracesList.add(traceName);
        }

        foodsList.add(
          Food(
            name: RxString(foodName.capitalizeFirst!),
            allergens: allergenesList,
            uploadTime: uploadDateTime,
            traces: tracesList,
            brand: RxString(brand.capitalizeFirst!),
            ingredients: ingredients,
          ),
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void clearFoodsList() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId.value)
        .collection('foods')
        .get();

    for (QueryDocumentSnapshot doc in snapshot.docs) {
      await doc.reference.delete();
    }

    getFoods();
  }

  void addAllergy(Allergy allergy) async {
    allergyAlreadyExistant.value = false;

    if (!allergiesList.contains(allergy)) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId.value)
          .collection('allergies')
          .add({
        'name': allergy.allergeneType.name,
      });
      getAllergies();
    } else {
      allergyAlreadyExistant.value = true;
    }
  }

  void removeAllergy(Allergy allergy) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId.value)
        .collection('allergies')
        .where('name', isEqualTo: allergy.allergeneType.name)
        .get();

    for (DocumentSnapshot doc in snapshot.docs) {
      await doc.reference.delete();
    }

    getAllergies();
  }

  Future<void> getAllergies() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId.value)
          .collection('allergies')
          .get();

      allergiesList.clear();

      for (QueryDocumentSnapshot doc in snapshot.docs) {
        String allergyName = doc['name'].toLowerCase();

        AllergeneType allergyType =
            AllergeneType.values.firstWhere((type) => type.name == allergyName);

        allergiesList.add(
          Allergy(
            allergeneType: allergyType,
          ),
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void addFoodFromBarcode(String barcode, BuildContext context) async {
    OpenFoodFactsApi.fetchFood(barcode, context).then((food) {
      if (food != null) {
        final Food foodResult = Food(
          name: food.name,
          allergens: food.allergens,
          traces: food.traces,
          brand: food.brand,
          uploadTime: DateTime.now(),
          ingredients: food.ingredients,
        );

        selectedFood.value = foodResult;

        addFood(foodResult);
        scanList.add(foodResult);
      } else {
        //TODO: show on screen
        print('Food not found.');
      }
    }).catchError((error) {
      //TODO: show on screen
      print('Failed to fetch food information: $error');
    });
  }

  Future<void> playSound() async {
    await audioPlayer.play(AssetSource("audio/success_audio.mp3"));
  }

  List<String> getCommonAllergies(
      List<String> allergiesFromFood, BuildContext context) {
    List<String> commonAllergens = [];

    print("allergies from food: ");

    for (String allergyItem in allergiesFromFood) {
      print(allergyItem);
    }

    print("----");

    print("allergies from user: ");

    for (Allergy allergyItem in allergiesList) {
      print(allergyItem.allergeneType.name);
    }

    print("----");

    for (String foodAllergy in allergiesFromFood) {
      for (Allergy userAllergy in allergiesList) {
        if (foodAllergy
            .toLowerCase()
            .contains(userAllergy.allergeneType.name)) {
          String allergyName =
              getLocalizedAllergyName(context, foodAllergy.toLowerCase());

          commonAllergens.add(allergyName);
        }
      }
    }

    print("common allergies:");

    for (String item in commonAllergens) {
      print(item);
    }

    return commonAllergens;
  }

  List<String> getCommonTraces(
      List<String> tracesFromFood, BuildContext context) {
    List<String> commonTraces = [];

    print("traces from food: ");

    for (String trace in tracesFromFood) {
      print(trace);
    }

    print("----");

    print("allergies from user: ");

    for (Allergy allergy in allergiesList) {
      print(allergy.allergeneType.name);
    }

    print("----");

    for (String foodTrace in tracesFromFood) {
      for (Allergy userAllergy in allergiesList) {
        if (foodTrace.toLowerCase().contains(userAllergy.allergeneType.name)) {
          String traceName =
              getLocalizedAllergyName(context, foodTrace.toLowerCase());

          commonTraces.add(traceName);
        }
      }
    }

    print("common traces:");

    for (String item in commonTraces) {
      print(item);
    }

    return commonTraces;
  }
}
