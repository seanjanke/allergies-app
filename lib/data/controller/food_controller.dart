import 'package:allergies/data/models/allergy.dart';
import 'package:allergies/data/models/food.dart';
import 'package:allergies/data/services/food_service.dart';
import 'package:get/get.dart';

class FoodController extends GetxController {
  RxList<Food> foodsList = <Food>[].obs;
  RxList<Allergy> allergiesList = <Allergy>[].obs;
  RxBool foodAlreadyExistant = false.obs;
  RxBool allergyAlreadyExistant = false.obs;

  void addFood(Food food) {
    foodAlreadyExistant.value = false;
    if (!foodsList.contains(food)) {
      foodsList.add(food);
    } else {
      foodAlreadyExistant.value = true;
    }
  }

  void removeFood(Food food) {
    if (foodsList.contains(food)) {
      foodsList.remove(food);
    } else {}
  }

  void addAllergy(Allergy allergy) {
    allergyAlreadyExistant.value = false;
    if (!allergiesList.contains(allergy)) {
      allergiesList.add(allergy);
    } else {
      allergyAlreadyExistant.value = true;
    }
  }

  void removeAllergy(Allergy allergy) {
    if (allergiesList.contains(allergy)) {
      allergiesList.remove(allergy);
    } else {}
  }

   void addFoodFromBarcode(String barcode) async {
    OpenFoodFactsApi.fetchAndPrintProduct(barcode).then((food) {
      if (food != null) {
        addFood(food);
        print('Added food: ${food.name}');
      } else {
        print('Food not found.');
      }
    }).catchError((error) {
      print('Failed to fetch food information: $error');
    });
  }
}
