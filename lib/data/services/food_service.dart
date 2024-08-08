import 'dart:convert';
import 'dart:developer';
import 'package:allergies/core/locales.dart';
import 'package:allergies/data/models/allergy.dart';
import 'package:allergies/data/models/food.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class OpenFoodFactsApi {
  static const String _baseUrl =
      'https://world.openfoodfacts.org/api/v0/product/';

  static Future<Food?> fetchAndPrintProduct(
    String barcode,
    BuildContext context,
  ) async {
    FlutterLocalization localization = FlutterLocalization.instance;
    final response = await http.get(Uri.parse('$_baseUrl$barcode.json'));

    String currentLanguage = localization.currentLocale!.languageCode;

    if (response.statusCode == 200) {
      final productData = json.decode(response.body);
      if (productData['status'] == 1) {
        final productInfo = productData['product'];

        String productName = "";

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

        List<String> allergies = [];
        if (productInfo.containsKey('allergens_tags')) {
          allergies = List<String>.from(productInfo['allergens_tags']);
        }

        List<String> allergiesList = [];
        for (String allergyItem in allergies) {
          for (AllergeneType allergy in AllergeneType.values) {
            if (allergyItem.contains(allergy.name.toLowerCase())) {
              String allergyName = getLocalizedAllergyName(
                context,
                allergy.name.toLowerCase(),
              );
              if (allergyName != "") {
                allergiesList.add(allergyName);
              }
            } else {
              // print("${allergy.name.toLowerCase()} is not included");
            }
          }
        }

        String ingredients = "";

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

        List<String> traces = [];
        if (productInfo.containsKey('traces_tags') &&
            productInfo['traces_tags'] != "") {
          for (AllergeneType allergy in AllergeneType.values) {
            for (String trace in productInfo['traces_tags']) {
              if (trace.contains(allergy.name.toLowerCase())) {
                String allergyName = getLocalizedAllergyName(
                  context,
                  allergy.name.toLowerCase(),
                );

                if (allergyName != "") {
                  traces.add(allergyName);
                }
                log("trace: $allergyName");
              }
            }
          }
        }

        if (productInfo.containsKey('traces_from_ingredients') &&
            productInfo['traces_from_ingredients'] != "") {
          List<String> allTracesFromIngredients =
              productInfo['traces_from_ingredients'].toString().split(' ');

          if (allTracesFromIngredients.isNotEmpty) {
            for (String trace in allTracesFromIngredients) {
              if (!traces.contains(trace)) {
                String traceName = getLocalizedAllergyName(
                  context,
                  trace.toLowerCase(),
                );

                if (traceName != "") {
                  traces.add(
                    traceName,
                  );
                }
              }
            }
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
