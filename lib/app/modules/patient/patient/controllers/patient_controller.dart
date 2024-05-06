import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sirs_apps/app/controllers/firestore_controller.dart';
import 'package:sirs_apps/app/data/patient.dart';
import 'package:sirs_apps/app/modules/patient/patient/views/widgets/patient_info_card.dart';

import '../../../../routes/app_pages.dart';
import '../../../../utils/constants.dart';

class PatientController extends GetxController {
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
            searchController.selection =
                TextSelection.collapsed(offset: searchController.text.length);
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
                data: filteredItem,
                editFunction: null,
                delateFunction: null,
                onTap: () {
                  searchController.closeView(filteredItem.patientName);
                  handleSelection(filteredItem);
                }),
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
