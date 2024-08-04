import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  Rx<ThemeMode> themeMode = ThemeMode.light.obs;

  @override
  void onInit() {
    getTheme();
    super.onInit();
  }

  void setTheme(ThemeMode newTheme) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('theme', newTheme.name);
  }

  void getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? theme = prefs.getString('theme') ?? "";

    if (theme != "") {
      if (theme == "light") {
        themeMode.value = ThemeMode.light;
      } else if (theme == "dark") {
        themeMode.value = ThemeMode.dark;
      } else if (theme == "system") {
        themeMode.value = ThemeMode.system;
      }
    } else {
      setTheme(ThemeMode.system);
    }
  }

  void changeTheme(ThemeMode newMode) {
    themeMode.value = newMode;
    setTheme(newMode);
  }

  void switchThroughThemes() {
    if (themeMode.value == ThemeMode.light) {
      changeTheme(ThemeMode.dark);
    } else if (themeMode.value == ThemeMode.dark) {
      changeTheme(ThemeMode.system);
    } else {
      changeTheme(ThemeMode.light);
    }
  }
}
