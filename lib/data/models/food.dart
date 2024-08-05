import 'package:get/get.dart';

class Food {
  final RxString name;
  final List<String> allergens;
  final String ingredients;
  final List<String> traces;
  final DateTime? uploadTime;

  const Food({
    required this.name,
    required this.allergens,
    required this.ingredients,
    required this.traces,
    this.uploadTime,
  });

  bool containsAllergen(String allergen) {
    return allergens.contains(allergen);
  }
}
