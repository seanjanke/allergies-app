import 'dart:convert';
import 'dart:developer';
import 'package:allergies/core/locales.dart';
import 'package:allergies/data/controller/food_controller.dart';
import 'package:allergies/data/models/allergy.dart';
import 'package:allergies/data/models/food.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class OpenFoodFactsApi {
  static const String _baseUrl =
      'https://world.openfoodfacts.org/api/v0/product/';

  static Future<Food?> fetchFood(
    String barcode,
    BuildContext context,
  ) async {
    FlutterLocalization localization = FlutterLocalization.instance;
    final FoodController foodController = Get.find();
    final response = await http.get(Uri.parse('$_baseUrl$barcode.json'));

    String currentLanguage = localization.currentLocale!.languageCode;

    if (response.statusCode == 200) {
      final productData = json.decode(response.body);
      if (productData['status'] == 1) {
        final productInfo = productData['product'];

        String productName = "";
        String ingredients = "";
        List<String> allergies = [];
        List<String> traces = [];
        String brand = "";

        //get product name

        if (currentLanguage == "de" &&
            productInfo.containsKey('product_name_de') &&
            productInfo['product_name_de'] != "") {
          productName = productInfo['product_name_de'];
        } else if (currentLanguage == "fr" &&
            productInfo.containsKey('product_name_fr') &&
            productInfo['product_name_fr'] != "") {
          productName = productInfo['product_name_fr'];
        } else if (currentLanguage == "es" &&
            productInfo.containsKey('product_name_es') &&
            productInfo['product_name_es'] != "") {
          productName = productInfo['product_name_es'];
        } else {
          productName = productInfo['product_name'];
        }

        //get allergens from tags

        if (productInfo.containsKey('allergens_tags')) {
          List<String> allAllergiesFromTags =
              List<String>.from(productInfo['allergens_tags']);

          for (String allergy in allAllergiesFromTags) {
            if (!allergies.contains(allergy)) {
              allergies.add(allergy);
            }
          }
        }

        //get allergens from ingredients

        if (productInfo.containsKey('allergens_from_ingredients') &&
            productInfo['allergens_from_ingredients'] != "") {
          String ingredientsString = productInfo['allergens_from_ingredients'];

          List<String> allAllergensFromIngredients =
              ingredientsString.split(',').map((item) => item.trim()).toList();

          if (allAllergensFromIngredients.isNotEmpty) {
            for (String allergen in allAllergensFromIngredients) {
              if (allergen != "" && !allergies.contains(allergen)) {
                allergies.add(allergen);
              }
            }
          }
        }

        //get ingredients

        if (currentLanguage == "de") {
          if (productInfo.containsKey('ingredients_text_de')) {
            ingredients = productInfo['ingredients_text_de'];
          } else {
            if (productInfo.containsKey('ingredients_text')) {
              ingredients = productInfo['ingredients_text'];
            } else {
              ingredients = LocaleData.noIngredientsFound.getString(context);
            }
          }
        } else if (currentLanguage == "en") {
          if (productInfo.containsKey('ingredients_text_en')) {
            ingredients = productInfo['ingredients_text_en'];
          } else {
            if (productInfo.containsKey('ingredients_text')) {
              ingredients = productInfo['ingredients_text'];
            } else {
              ingredients = LocaleData.noIngredientsFound.getString(context);
            }
          }
        } else if (currentLanguage == "es") {
          if (productInfo.containsKey('ingredients_text_es')) {
            ingredients = productInfo['ingredients_text_es'];
          } else {
            if (productInfo.containsKey('ingredients_text')) {
              ingredients = productInfo['ingredients_text'];
            } else {
              ingredients = LocaleData.noIngredientsFound.getString(context);
            }
          }
        } else if (currentLanguage == "fr") {
          if (productInfo.containsKey('ingredients_text_fr')) {
            ingredients = productInfo['ingredients_text_fr'];
          } else {
            if (productInfo.containsKey('ingredients_text')) {
              ingredients = productInfo['ingredients_text'];
            } else {
              ingredients = LocaleData.noIngredientsFound.getString(context);
            }
          }
        }

        //get traces from tags

        if (productInfo.containsKey('traces_tags') &&
            productInfo['traces_tags'] != "") {
          for (String trace in productInfo['traces_tags']) {
            if (trace != "" && !traces.contains(trace)) {
              traces.add(trace);
            }
          }
        }

        //get traces from ingredients

        if (productInfo.containsKey('traces_from_ingredients') &&
            productInfo['traces_from_ingredients'] != "") {
          List<String> allTracesFromIngredients =
              productInfo['traces_from_ingredients'].toString().split(' ');

          if (allTracesFromIngredients.isNotEmpty) {
            for (String trace in allTracesFromIngredients) {
              if (trace != "" && !traces.contains(trace)) {
                traces.add(trace);
              }
            }
          }
        }

        //get brand

        if (productInfo.containsKey('brands') && productInfo['brands'] != "") {
          brand = productInfo['brands'];
          print("brand found: $brand");
        }

        //print allergies

        log("final allergies: ");
        for (String allergy in allergies) {
          log(allergy);
        }

        //print traces

        log("final traces: ");
        for (String trace in traces) {
          log(trace);
        }

        return Food(
          name: RxString(productName),
          allergens: allergies,
          ingredients: ingredients,
          traces: traces,
          brand: RxString(brand),
          uploadTime: DateTime.now(),
        );
      } else {
        //TODO: show on screen
        print('Product not found.');
        return null;
      }
    } else {
      //TODO: show on screen
      print('Failed to load product information.');
      return null;
    }
  }
}
