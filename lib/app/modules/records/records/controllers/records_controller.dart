import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:sirs_apps/app/controllers/firestore_controller.dart';

class RecordsController extends GetxController {
  //TODO: Implement RecordsController
  final firestoreC = Get.put(FirestoreControllerUp());
  final fkey = GlobalKey<FormState>();
  final docId = ''.obs;
  final recordNameC = TextEditingController();
  final diagnosisC = TextEditingController();
  final additionalNotesC = TextEditingController();

  void saveItem() async {
    if (fkey.currentState!.validate()) {
      fkey.currentState!.save();

      EasyLoading.show(status: 'Menyimpan data pasien...');

      firestoreC.addRecordToPatient(
        docId.value,
        {
          'record_name': recordNameC.text,
          'diagnoses': diagnosisC.text,
          'additional_notes': additionalNotesC.text,
          'created_at': DateTime.now().toIso8601String(),
        },
      );

      EasyLoading.dismiss();
      Navigator.pop(Get.context!);
    }
  }

  @override
  void onInit() {
    docId.value = Get.arguments['docId'];
    debugPrint('SIU: ${docId.value}');
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
