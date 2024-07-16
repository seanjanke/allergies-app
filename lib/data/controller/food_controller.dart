import 'package:allergies/data/models/allergy.dart';
import 'package:get/get.dart';

class FoodController extends GetxController {
  RxList<Allergy> allergiesList = <Allergy>[].obs;
  RxBool allergyAlreadyExistant = false.obs;

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
}
