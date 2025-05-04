import 'package:eventhub/views/sign_in_screen.dart' show SignInScreen;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  final currentPage = 0.obs;
  late PageController pageController;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: 0);
  }

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  void onDotClicked(int index) {
    currentPage.value = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void nextPage() {
    if (currentPage.value < 2) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      navigateToSignIn();
    }
  }

  void skipToSignIn() {
    navigateToSignIn();
  }

  void navigateToSignIn() {
    Get.offAll(() => SignInScreen());
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
