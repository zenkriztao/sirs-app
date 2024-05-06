import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:sirs_apps/app/controllers/firestore_controller.dart';
import 'package:sirs_apps/app/data/patient.dart';
import 'package:sirs_apps/app/utils/constants.dart';
import 'package:intl/intl.dart';

class PatientAddController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController = TabController(length: 0, vsync: this); //
  final pageType = PageType.TAMBAH.obs;
  final docId = ''.obs;
  final tempBirth = ''.obs;
  final firestoreC = Get.put(FirestoreControllerUp());
  final formKey = GlobalKey<FormState>();
  late TextEditingController patientName;
  final sex = ''.obs;
  late TextEditingController address;
  late TextEditingController dateOfBirthC;
  DateTime dateOfBirth =
      DateTime.now().subtract(const Duration(days: 365 * 18));
  //CASE DETAIL & EDIT PATIENT
  final isDone = false.obs;

  void saveItem() async {
    if (formKey.currentState!.validate()) {
      if (sex.value == "") {
        //TODO forget asign sex
        Get.showSnackbar(
          const GetSnackBar(
            backgroundColor: Colors.red,
            message: 'You must fill all the form!',
            duration: Duration(seconds: 2),
          ),
        );
        return;
      }
      formKey.currentState!.save();

      EasyLoading.show(status: 'Menyimpan data pasien...');
      if (pageType.value == PageType.TAMBAH) {
        await firestoreC.addPatient(
          Patient(
            patientName: patientName.value.text,
            sex: sex.value.trim(),
            records: [],
            address: address.value.text,
            dateOfBirth: dateOfBirth.toIso8601String(),
          ),
        );
        EasyLoading.dismiss();
        Navigator.pop(Get.context!);

        debugPrint('add successfuly');
      } else {
        await firestoreC.editPatient(
          docId.value,
          Patient(
            patientName: patientName.value.text,
            sex: sex.value.trim(),
            records: [],
            address: address.value.text,
            dateOfBirth: dateOfBirth.toIso8601String(),
          ),
        );
        Navigator.pop(Get.context!);
        EasyLoading.dismiss();
      }
    }
  }

  void initDetailPatient() async {
    isDone.value = false;
    final patient = await firestoreC.getPatient(docId.value);
    patientName.text = patient.patientName;
    sex.value = patient.sex;
    address.text = patient.address;
    // patientName.text = 'Arrahmanul Hakim';
    // sex.value = 'M';
    // address.text = 'Perumahan Pinangmas Blok 01 No 10, Bengkulu, Indonesia';
    isDone.value = true;
  }

  @override
  void onInit() {
    pageType.value = Get.arguments[0]['pageType'];

    if (pageType.value == PageType.TAMBAH) {
      patientName = TextEditingController();
      address = TextEditingController();
      dateOfBirthC = TextEditingController();
    } else {
      tabController = TabController(length: 2, vsync: this);
      final temp = Get.arguments[0]['dateOfBirth'];
      docId.value = Get.arguments[0]['docId'];
      // const temp = "1964-01-01T00:00:00.000";
      // docId.value = 'JunjG9aemX5rhuqoOY0T';
      patientName = TextEditingController();
      address = TextEditingController();
      String format = 'dd/MM/yyyy';
      DateTime parsedDateTime = DateTime.parse(temp);
      DateFormat formatter = DateFormat(format);
      String dateString = formatter.format(parsedDateTime);
      dateOfBirthC = TextEditingController(text: dateString);
      dateOfBirth = formatter.parse(dateString);
      initDetailPatient();
    }
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    tabController.dispose();
    patientName.dispose();
    address.dispose();
    dateOfBirthC.dispose();
  }
}
