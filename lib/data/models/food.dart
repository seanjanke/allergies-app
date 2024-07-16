import 'package:get/get.dart';

class Food {
  final RxString name;
  final List<String> allergens;

  const Food({
    required this.name,
    required this.allergens,
  });

  bool containsAllergen(String allergen) {
    return allergens.contains(allergen);
  }
}
