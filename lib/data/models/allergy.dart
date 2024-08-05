import 'package:allergies/core/locales.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

enum AllergeneType {
  lactose,
  nuts,
  gluten,
  shellfish,
  eggs,
  soy,
  wheat,
  fish,
  peanuts,
  sesame,
  fructose,
}

List<Allergy> allAllergies = const [
  Allergy(
    allergeneType: AllergeneType.lactose,
    imagePath: "assets/images/lactose_asset.png",
  ),
  Allergy(
    allergeneType: AllergeneType.shellfish,
    imagePath: "assets/images/shellfish_asset.png",
  ),
  Allergy(
    allergeneType: AllergeneType.wheat,
    imagePath: "assets/images/wheat_asset.png",
  ),
  Allergy(
    allergeneType: AllergeneType.fish,
    imagePath: "assets/images/fish_asset.png",
  ),
  Allergy(
    allergeneType: AllergeneType.fructose,
    imagePath: "assets/images/fructose_asset-2.png",
  ),
  Allergy(
    allergeneType: AllergeneType.eggs,
    imagePath: "assets/images/eggs_asset-2.png",
  ),
];

class Allergy {
  final AllergeneType allergeneType;
  final String? imagePath;

  const Allergy({required this.allergeneType, this.imagePath});

  String name(BuildContext context) {
    if (context.mounted) {
      switch (allergeneType) {
        case AllergeneType.lactose:
          return LocaleData.lactose.getString(context);
        case AllergeneType.nuts:
          return LocaleData.nuts.getString(context);
        case AllergeneType.gluten:
          return LocaleData.gluten.getString(context);
        case AllergeneType.shellfish:
          return LocaleData.shellfish.getString(context);
        case AllergeneType.eggs:
          return LocaleData.eggs.getString(context);
        case AllergeneType.soy:
          return LocaleData.soy.getString(context);
        case AllergeneType.wheat:
          return LocaleData.wheat.getString(context);
        case AllergeneType.fish:
          return LocaleData.fish.getString(context);
        case AllergeneType.peanuts:
          return LocaleData.peanuts.getString(context);
        case AllergeneType.sesame:
          return LocaleData.sesame.getString(context);
        case AllergeneType.fructose:
          return LocaleData.fructose.getString(context);
      }
    } else {
      return "";
    }
  }
}
