import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sirs_apps/app/controllers/auth_controller.dart';
import 'package:sirs_apps/app/controllers/firestore_controller.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:sirs_apps/app/modules/patient/patient/controllers/patient_controller.dart';
import 'package:sirs_apps/app/utils/constants.dart';

class HomeController extends GetxController {
  final box = GetStorage();
  final fireC = Get.put(FirestoreControllerUp(), permanent: true);
  final authC = Get.find<AuthController>();
  final patientC = Get.put(PatientController());
  TextEditingController textC = TextEditingController();

  //TODO: Implement HomeController
  final totalRecord = 0.obs;
  final totalMale = 0.obs;
  final totalFemale = 0.obs;
  final totalPatients = 0.obs;

  //TODO : User Defined Function
  final firstName = ''.obs;
  final LastName = ''.obs;

  void initUser() {
    firstName.value = box.read('firstName');
    LastName.value = box.read('lastName');
  }

  void initData() async {
    totalRecord.value = await fireC.totalRecords();
    totalMale.value = await fireC.totalPatientMale();
    totalFemale.value = await fireC.totalPatientFemale();
    totalPatients.value = await fireC.totalPatients();
  }

  void logout() {
    PanaraConfirmDialog.show(
      Get.context!,
      title: "Konfirmasi",
      message: "Apakah anda yakin untuk keluar akun?",
      confirmButtonText: "Tidak",
      cancelButtonText: "Ya",
      onTapCancel: () {
        authC.logout();
      },
      onTapConfirm: () {
        Navigator.pop(Get.context!);
      },
      panaraDialogType: PanaraDialogType.custom,
      color: kPrimaryblue500,
      buttonTextColor: Colors.white,
      barrierDismissible: false,
    );
  }

  Future refreshData() async {
    initData();
  }

  @override
  void onInit() {
    initData();
    initUser();
    super.onInit();
    patientC.searchController = SearchController();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
