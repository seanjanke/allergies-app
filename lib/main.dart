import 'package:allergies/app.dart';
import 'package:allergies/data/controller/food_controller.dart';
import 'package:allergies/data/services/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  Get.put(FoodController());

  runApp(const AllergiesApp());
}
