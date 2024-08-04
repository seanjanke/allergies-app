import 'package:allergies/core/about.dart';
import 'package:allergies/core/locales.dart';
import 'package:allergies/core/routing.dart';
import 'package:allergies/core/theme/theme.dart';
import 'package:allergies/data/controller/theme_controller.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_localization/flutter_localization.dart';

class AllergiesApp extends StatefulWidget {
  const AllergiesApp({super.key});

  @override
  State<AllergiesApp> createState() => _AllergiesAppState();
}

class _AllergiesAppState extends State<AllergiesApp> {
  ThemeController controller = Get.put(ThemeController());

  final FlutterLocalization localization = FlutterLocalization.instance;

  void configureLocalization() {
    localization.init(mapLocales: LOCALES, initLanguageCode: "en");
    localization.onTranslatedLanguage = onTranslatedLanguage;
  }

  void onTranslatedLanguage(Locale? locale) {
    setState(() {});
  }

  @override
  void initState() {
    configureLocalization();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GetMaterialApp.router(
        title: appName,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: controller.themeMode.value,
        debugShowCheckedModeBanner: false,
        routeInformationParser: BeamerParser(),
        routerDelegate: routerDelegate,
        supportedLocales: localization.supportedLocales,
        localizationsDelegates: localization.localizationsDelegates,
      ),
    );
  }
}
