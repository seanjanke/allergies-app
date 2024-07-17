import 'package:allergies/data/models/allergy.dart';
import 'package:allergies/data/models/food.dart';
import 'package:allergies/data/services/food_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FoodController extends GetxController {
  RxString userId = "".obs;
  RxList<Food> foodsList = <Food>[].obs;
  RxList<Allergy> allergiesList = <Allergy>[].obs;
  RxBool foodAlreadyExistant = false.obs;
  RxBool allergyAlreadyExistant = false.obs;

  @override
  void onInit() {
    getUserId();
    super.onInit();
  }

  void setUserId(String newUserId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId.value = newUserId;

    await prefs.setString('userId', newUserId);
  }

  void getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String userIdPrefs = prefs.getString('userId') ?? '';
    userId.value = userIdPrefs;
    print("got user id from shared prefs: $userId");
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

    print('d');

    print("foodlist:");
    for (Food item in foodsList) {
      print(item.name.value);
    }

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

    print('g');

    docRef.update({'id': docRef.id});

    print('h');

    for (String allergy in food.allergens) {
      print('i');
      docRef.collection('allergies').doc(allergy).set({
        'name': allergy,
      });
    }
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

  void getAllergies() async {
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
  }

  void addFoodFromBarcode(String barcode) async {
    OpenFoodFactsApi.fetchAndPrintProduct(barcode).then((food) {
      if (food != null) {
        addFood(food);
      } else {
        print('Food not found.');
      }
    }).catchError((error) {
      print('Failed to fetch food information: $error');
    });
  }
}
