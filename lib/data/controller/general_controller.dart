import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GeneralController extends GetxController {
  RxBool useHapticFeedback = true.obs;

  @override
  void onInit() {
    getHapticFeedbackBool();
    super.onInit();
  }

  void getHapticFeedbackBool() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final bool? useHapticFeedbackPref = prefs.getBool("hapticFeedback");

    if (useHapticFeedbackPref != null) {
      useHapticFeedback.value = useHapticFeedbackPref;
    } else {
      setHapticFeedback(true);
    }
  }

  void setHapticFeedback(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setBool("hapticFeedback", true);
  }

  void toggleHapticFeedback() {
    if (useHapticFeedback.value == true) {
      useHapticFeedback.value = false;
      setHapticFeedback(false);
    } else {
      useHapticFeedback.value = true;
      setHapticFeedback(true);
    }
  }
}
