import 'package:allergies/core/about.dart';
import 'package:allergies/core/routing.dart';
import 'package:allergies/core/theme/theme.dart';
import 'package:allergies/data/controller/theme_controller.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllergiesApp extends StatelessWidget {
  const AllergiesApp({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeController controller = Get.put(ThemeController());

    return Obx(
      () => GetMaterialApp.router(
        title: appName,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: controller.themeMode.value,
        debugShowCheckedModeBanner: false,
        routeInformationParser: BeamerParser(),
        routerDelegate: routerDelegate,
      ),
    );
  }
}
