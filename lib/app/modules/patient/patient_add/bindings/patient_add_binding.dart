import 'package:get/get.dart';

import '../controllers/patient_add_controller.dart';

class PatientAddBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PatientAddController>(
      () => PatientAddController(),
    );
  }
}
