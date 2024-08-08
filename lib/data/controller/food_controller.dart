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
  RxList<Allergy> allergiesList = <Allergy>[].obs;
  RxBool foodAlreadyExistant = false.obs;
  RxBool allergyAlreadyExistant = false.obs;
  RxList<String> qrCodesList = <String>[].obs;
  final audioPlayer = AudioPlayer();
  Rx<Food> selectedFood = Food(
    name: RxString(""),
    allergens: [],
    traces: [],
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
      allergiesList.add(allergy);
    } else {
      allergyAlreadyExistant.value = true;
    }
  }

  void removeAllergy(Allergy allergy) async {
    allergiesList.remove(allergy);

    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId.value)
        .collection('allergies')
        .where('name', isEqualTo: allergy.allergeneType.name)
        .get();

    for (DocumentSnapshot doc in snapshot.docs) {
      await doc.reference.delete();
    }
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
    OpenFoodFactsApi.fetchAndPrintProduct(barcode, context).then((food) {
      if (food != null) {
        List<String> commonAllergens = food.allergens.where((allergy) {
          return allergiesList.any((controllerAllergy) =>
              controllerAllergy.name(context).toLowerCase() ==
              allergy.toLowerCase());
        }).toList();

        selectedFood.value = Food(
          name: food.name,
          allergens: commonAllergens,
          traces: food.traces,
          ingredients: food.ingredients,
        );

        addFood(food);
        scanList.add(food);
      } else {
        print('Food not found.');
      }
    }).catchError((error) {
      print('Failed to fetch food information: $error');
    });
  }

  Future<void> playSound() async {
    await audioPlayer.play(AssetSource("audio/success_audio.mp3"));
  }
}
