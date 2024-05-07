import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import '../../home/controllers/home_controller.dart';
import '../../patient/patient/controllers/patient_controller.dart';
import '../../profile/controllers/profile_controller.dart';

class LayoutNavigationBarController extends GetxController {
  // TODO: Implement New LayoutNavigationBarController
  final selectedIndex = 1.obs;
  void onItemTapped(int index) {
    selectedIndex.value = index;
    update();
  }

  // TODO: Implement LayoutNavigationBarController
  final pageController = PageController(initialPage: 1);
  final HomeController homeC;
  final PatientController patientC;
  final ProfileController profileC;

  LayoutNavigationBarController()
      : patientC = Get.put(PatientController()),
        homeC = Get.put(HomeController()),
        profileC = Get.put(ProfileController());
  // final pageController = PageController(initialPage: 1);
  // late HomeController homeC;
  // late PatientController patientC;
  // late ProfileController profileC;

  final index = 1.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    // pageController.animateToPage(index.value,
    //     duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    // super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
