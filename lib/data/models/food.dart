import 'package:allergies/data/models/allergy.dart';
import 'package:get/get.dart';

class Food {
  final RxString name;
  final List<Allergies> allergens;

  const Food({
    required this.name,
    required this.allergens,
  });

  bool containsAllergen(Allergies allergen) {
    return allergens.contains(allergen);
  }
}
