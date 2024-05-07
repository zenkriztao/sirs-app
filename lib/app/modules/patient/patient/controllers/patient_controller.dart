import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sirs_apps/app/controllers/firestore_controller.dart';
import 'package:sirs_apps/app/data/patient.dart';
import 'package:sirs_apps/app/modules/patient/patient/views/widgets/patient_info_card.dart';

import '../../../../routes/app_pages.dart';
import '../../../../utils/constants.dart';
import '../views/widgets/input_pin_edit.dart';

class PatientController extends GetxController {
  final pin = 0.obs;
  final pinController = TextEditingController();
  final pinVisibility = true.obs;
  final pinFormKey = GlobalKey<FormState>();

  Future<void> validateEditPin(
    int oldPin,
    Map<String, dynamic> body,
    BuildContext? context,
  ) async {
    print('validateEditPin is being called with pin: $pin,, context: $context');

    if (pinFormKey.currentState != null &&
        pinFormKey.currentState!.validate()) {
      pinFormKey.currentState!.save();
      final box = GetStorage();
      final uid = box.read('uid');
      try {
        EasyLoading.show();
        DocumentSnapshot doc =
            await FirebaseFirestore.instance.collection('users').doc(uid).get();
        final validPin = doc['pin'] as int;
        if (validPin == oldPin) {
          Navigator.pop(context!);
          EasyLoading.dismiss();
          editPatient(body);
        } else {
          EasyLoading.dismiss();
          Get.showSnackbar(
            const GetSnackBar(
              title: 'Error',
              message: "Old pin is incorrect!",
              duration: const Duration(seconds: 2),
            ),
          );
        }
      } on FirebaseException catch (e) {
        print('Edit patient ERROR! FIREBASE');

        EasyLoading.dismiss();
        Get.showSnackbar(
          GetSnackBar(
            title: 'Error',
            message: e.message ?? "An unexpected error occurred!",
            duration: const Duration(seconds: 2),
          ),
        );
      } catch (e) {
        EasyLoading.dismiss();
        Get.showSnackbar(
          const GetSnackBar(
            title: 'Error',
            message: "An unexpected error occurred!",
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  //TODO: implement Search Bar
  SearchController searchController = SearchController();
  final List<Patient> searchHistory = <Patient>[];
  final List<Patient> dataPatientSearchBar = [];

  Iterable<Widget> getHistoryList(SearchController searchController) {
    return searchHistory.map(
      (item) => ListTile(
        leading: const Icon(Icons.history),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(item.patientName),
            Text(item.dateOfBirth),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.call_missed),
          onPressed: () {
            searchController.text = item.patientName;
            searchController.selection = TextSelection.collapsed(
              offset: searchController.text.length,
            );
          },
        ),
      ),
    );
  }

  Iterable<Widget> getSuggestions(SearchController searchController) {
    final String input = searchController.value.text;
    final dataSearch = dataPatientSearchBar
        .where((item) => item.patientName.toString().toLowerCase().contains(
              input.toLowerCase(),
            ));
    return dataSearch.isEmpty
        ? [
            const Center(
              child: Text(
                'Data not found.',
                style: TextStyle(
                  color: colorTextSmall,
                ),
              ),
            )
          ]
        : dataSearch.map(
            (filteredItem) => PatientInfoCard(
              show: true,
              data: filteredItem,
              editFunction: () {
                Get.bottomSheet(
                  InputPinEdit(
                    data: filteredItem,
                    controller: this,
                    onSubmit: () async {
                      await validateEditPin(
                          int.parse(pinController.text),
                          {
                            'pageType': PageType.EDIT,
                            'docId': filteredItem.docId,
                            'dateOfBirth': filteredItem.dateOfBirth,
                          },
                          Get.context);
                    },
                  ),
                  barrierColor: Colors.black.withOpacity(0.5),
                  backgroundColor: Colors.white,
                );
              },
              delateFunction: () {
                Navigator.pop(Get.context!);
                showModalBottomSheet(
                  context: Get.context!,
                  builder: (context) {
                    return InputPinEdit(
                      controller: this,
                      data: filteredItem,
                      onSubmit: () {
                        deletePatient(filteredItem.docId!);
                      },
                    );
                  },
                );
              },
              onTap: () {
                searchController.closeView(filteredItem.patientName);
                handleSelection(filteredItem);
              },
            ),
          );
  }

  void handleSelection(Patient selectedPatient) {
    if (searchHistory.length >= 5) {
      searchHistory.removeLast();
    }
    searchHistory.insert(0, selectedPatient);

    Get.toNamed(
      Routes.PATIENT_ADD,
      arguments: [
        {
          'pageType': PageType.DETAIL,
          'docId': selectedPatient.docId,
          'dateOfBirth': selectedPatient.dateOfBirth,
        },
      ],
    );
  }

  void clearHistory() {
    searchHistory.clear();
  }

  void openSearchView() {
    searchController.openView();
  }

  //TODO: get firestore instance
  final firestoreC = Get.put(FirestoreControllerUp());
  final dataPatient = <Patient>[];
  final isDone = false.obs;
  final isLoadData = false.obs;

  initPatientList() async {
    pin.value = GetStorage().read('pin');
    print('PIN: ${pin}');
    isDone.value = false;
    final temp = await firestoreC.patientList();
    debugPrint('Success');
    if (dataPatient.isNotEmpty || dataPatientSearchBar.isNotEmpty) {
      dataPatient.clear();
      dataPatientSearchBar.clear();
    }
    dataPatient.addAll(temp);
    dataPatientSearchBar.addAll(temp);
    isDone.value = true;
  }

  Future refreshData() async {
    initPatientList();
  }

  void toPatientDetail(Map<String, dynamic> body) {
    Get.toNamed(Routes.PATIENT_ADD, arguments: [body]);
  }

  void editPatient(Map<String, dynamic> body) {
    Get.toNamed(
      Routes.PATIENT_ADD,
      arguments: [body],
    );
  }

  void deletePatient(String docId) {
    //Make this close pop context
    Get.back();
    firestoreC.deletePatient(docId);
  }

  @override
  void onInit() {
    initPatientList();
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
}
