import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:sirs_apps/app/utils/constants.dart';
import 'package:sirs_apps/app/utils/popup.dart';

import '../../../routes/app_pages.dart';

class ProfileController extends GetxController {
  final box = GetStorage();

  // Future<void> logout() async {
  //   FirebaseAuth auth = FirebaseAuth.instance;
  //   await auth.signOut();

  //   Get.offAllNamed(Routes.LOGIN);
  //   box.remove('email');
  //   box.remove('uid');
  //   box.remove('firstName');
  //   box.remove('lastName');
  //   box.remove('pin');
  //   box.remove('role');
  // }

  void logout() {
    PanaraConfirmDialog.show(
      Get.context!,
      title: "Confirmation",
      message: "Are you sure you want to sing out?",
      confirmButtonText: "Back",
      cancelButtonText: "Yes",
      panaraDialogType: PanaraDialogType.custom,
      onTapConfirm: () {
        Get.back();
      },
      onTapCancel: () async {
        EasyLoading.show(status: 'Logging out...');
        await Future.delayed(
            const Duration(milliseconds: 900)); // Add delay here

        FirebaseAuth auth = FirebaseAuth.instance;
        await auth.signOut();

        Get.offAllNamed(Routes.LOGIN);
        box.remove('email');
        box.remove('uid');
        box.remove('firstName');
        box.remove('lastName');
        box.remove('pin');
        box.remove('role');
        EasyLoading.dismiss();
      },
      color: colorPrimaryL,
      buttonTextColor: Colors.white,
      barrierDismissible: false, // optional parameter (default is true)
    );
  }

  //TODO : User Defined Function
  final firstName = ''.obs;
  final LastName = ''.obs;
  final email = ''.obs;
  final role = ''.obs;
  final pin = 0.obs;

  void initUser() {
    firstName.value = box.read('firstName');
    LastName.value = box.read('lastName');
    email.value = box.read('email');
    role.value = box.read('role');
    pin.value = box.read('pin');
  }

  final count = 0.obs;
  @override
  void onInit() {
    initUser();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
