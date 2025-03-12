import 'package:event_hub/views/sign_in_screen.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController {
  void startTimer() {
    Future.delayed(const Duration(seconds: 3), () {
      // if (!Get.isRegistered<OnboardingController>()) {
      //   Get.put(OnboardingController());
      // }

      Get.offAll(() => SignInScreen());
    });
  }

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }
}
