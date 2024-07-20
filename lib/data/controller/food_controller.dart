import 'package:allergies/data/models/allergy.dart';
import 'package:allergies/data/models/food.dart';
import 'package:allergies/data/services/food_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

    print('got user id');
  }

  void addFood(Food food) async {
    foodAlreadyExistant.value = false;

    for (Allergy allgy in allergiesList) {
      if (food.allergens.contains(allgy.allergy.name.toLowerCase())) {
        print('allergy found: ${allgy.allergy.name}');
      }
    }

    if (userId.value.isEmpty) {
      DocumentReference docRefUser = await FirebaseFirestore.instance
          .collection('users')
          .add({'userId': ''});
      docRefUser.update({'userId': docRefUser.id});

      setUserId(docRefUser.id);
    }

    foodsList.clear();

    print('foodslist lenght before: ${foodsList.length}');
    foodsList.add(food);
    print('foodslist lenght after: ${foodsList.length}');
    DocumentReference docRef = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId.value)
        .collection('foods')
        .add({
      'id': 'id',
      'name': food.name.value,
      'timestamp': FieldValue.serverTimestamp(),
    });

    docRef.update({'id': docRef.id});

    for (String allergy in food.allergens) {
      docRef.collection('allergies').doc(allergy).set({
        'name': allergy,
      });
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

        List<String> allergenesList = [];

        for (QueryDocumentSnapshot doc in snapshot.docs) {
          print("allergene found: ${doc['name'].toLowerCase()}");
          String allergyName = doc['name'].toLowerCase();
          allergenesList.add(allergyName);
        }

        foodsList.add(
          Food(
            name: RxString(foodName.capitalizeFirst!),
            allergens: allergenesList,
            uploadTime: uploadDateTime,
          ),
        );
      }
    } catch (e) {
      print(e.toString());
    }

    print('got foods');
  }

  void addAllergy(Allergy allergy) {
    allergyAlreadyExistant.value = false;
    if (!allergiesList.contains(allergy)) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(userId.value)
          .collection('allergies')
          .add({
        'name': allergy.name,
      });
    } else {
      allergyAlreadyExistant.value = true;
    }
  }

  void removeAllergy(Allergy allergy) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId.value)
        .collection('allergies')
        .where('name', isEqualTo: allergy.name)
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

        Allergies? allergyEnum = Allergies.values.firstWhereOrNull(
          (element) => element.name.toLowerCase() == allergyName,
        );

        if (allergyEnum != null) {
          allergiesList.add(
            Allergy(
              allergy: allergyEnum,
            ),
          );
        } else {
          print("Allergy not found for name: $allergyName");
        }
      }
    } catch (e) {
      print(e.toString());
    }

    print('got allergies');
  }

  void addFoodFromBarcode(String barcode) async {
    OpenFoodFactsApi.fetchAndPrintProduct(barcode).then((food) {
      if (food != null) {
        addFood(food);
        scanList.add(food);
      } else {
        print('Food not found.');
      }
    }).catchError((error) {
      print('Failed to fetch food information: $error');
    });
  }
}
