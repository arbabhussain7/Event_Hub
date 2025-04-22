import 'package:event_hub/views/bottom_naivgation_bar_screen.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController {
  void startTimer() {
    Future.delayed(const Duration(seconds: 3), () {
      // if (!Get.isRegistered<OnboardingController>()) {
      //   Get.put(OnboardingController());
      // }

      Get.offAll(() => BottomNavigationBarScreen());
    });
  }

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }
}
