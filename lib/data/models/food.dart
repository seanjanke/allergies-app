import 'package:get/get.dart';

class Food {
  final RxString name;
  final List<String> allergens;
  final DateTime? uploadTime;

  const Food({
    required this.name,
    required this.allergens,
    this.uploadTime,
  });

  bool containsAllergen(String allergen) {
    return allergens.contains(allergen);
  }
}
