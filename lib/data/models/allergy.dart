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

class Allergy {
  final AllergeneType allergy;
  //TODO: add icon or image here

  const Allergy({required this.allergy});

  String name(BuildContext context) {
    switch (allergy) {
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
  }
}
