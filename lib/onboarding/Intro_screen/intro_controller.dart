import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IntroScreenController extends GetxController {
  late PageController pageController;
  int index = 0;

  @override
  void onInit() async {
    super.onInit();
    pageController = PageController();
    update();
  }

  //Navigating to new screen
  void pageNavigator() {
    if (pageController.hasClients && index < 3) {
      index = index + 1;
      pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 400),
        curve: Curves.bounceOut,
      );
      update();
    }
  }
}
