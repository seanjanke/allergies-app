import 'dart:convert';
import 'dart:developer';
import 'package:allergies/data/controller/food_controller.dart';
import 'package:allergies/data/models/allergy.dart';
import 'package:allergies/data/models/food.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class OpenFoodFactsApi {
  FoodController foodController = Get.find();
  static const String _baseUrl =
      'https://world.openfoodfacts.org/api/v0/product/';

  static Future<void> fetchAndPrintProductInfos(String barcode) async {
    final response = await http.get(Uri.parse('$_baseUrl$barcode.json'));

    if (response.statusCode == 200) {
      final productData = json.decode(response.body);
      if (productData['status'] == 1) {
        final productInfo = productData['product'] as Map<String, dynamic>;
        log('Product Information:');
        for (var key in productInfo.keys) {
          log('$key: ${productInfo[key]}');
        }
      } else {
        log('Product not found.');
      }
    } else {
      log('Failed to load product information.');
    }
  }

  static Future<Food?> fetchAndPrintProduct(String barcode) async {
    final response = await http.get(Uri.parse('$_baseUrl$barcode.json'));

    if (response.statusCode == 200) {
      final productData = json.decode(response.body);
      if (productData['status'] == 1) {
        final productInfo = productData['product'];

        String productName = productInfo['product_name_de'];

        List<String> allergies = [];
        if (productInfo.containsKey('allergens_tags')) {
          allergies = List<String>.from(productInfo['allergens_tags']);
        }

        List<String> allergiesList = [];
        for (String allergyItem in allergies) {
          for (AllergeneType allergy in AllergeneType.values) {
            if (allergyItem.contains(allergy.name.toLowerCase())) {
            
              allergiesList.add(allergy.name.capitalizeFirst!);
            } else {
              // print("${allergy.name.toLowerCase()} is not included");
            }
          }
        }

        String ingredients = "";
        if (productInfo.containsKey('ingredients_text')) {
          ingredients = productInfo['ingredients_text'];
        }

        List<String> traces = [];
        if (productInfo.containsKey('traces_tags')) {
          for (String trace in productInfo['traces_tags']) {
            traces.add(trace);
          }
        }

        return Food(
          name: RxString(productName),
          allergens: allergiesList,
          ingredients: ingredients,
          traces: traces,
          uploadTime: DateTime.now(),
        );
      } else {
        print('Product not found.');
        return null;
      }
    } else {
      print('Failed to load product information.');
      return null;
    }
  }
}
