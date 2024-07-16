import 'package:allergies/data/models/rive_model.dart';

class NavItemModel {
  final String title;
  final RiveModel rive;

  NavItemModel({required this.title, required this.rive});
}

List<NavItemModel> bottomNavItems = [
  NavItemModel(
    title: "Scan 1",
    rive: RiveModel(
      src: "assets/animations/allergiesapp.riv",
      artboard: "Scan",
      stateMachineName: "State Machine 1",
    ),
  ),
  NavItemModel(
    title: "Scan 2",
    rive: RiveModel(
      src: "assets/animations/allergiesapp.riv",
      artboard: "Scan",
      stateMachineName: "State Machine 1",
    ),
  ),
];
