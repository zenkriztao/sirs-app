import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/patient.dart';

class FirestoreControllerUp extends GetxController {
  // Create a CollectionReference called 'patients' that references the Firestore collection
  CollectionReference patients =
      FirebaseFirestore.instance.collection('patients');

  // Future<void> uploadData() async {
  //   for (var patient in dataUpload) {
  //     await patients.add(patient);
  //   }
  //   debugdebugPrint('Data uploaded successfully!');
  // }

  //TODO GET PATIENT LIST
  Future<List<Patient>> patientList() async {
    QuerySnapshot querySnapshot = await patients.get();
    List<Patient> patientsList = querySnapshot.docs
        .map((doc) =>
            Patient.fromMap(doc.data() as Map<String, dynamic>, docId: doc.id))
        .toList();
    return patientsList;
  }

  //TODO GET PATIENT
  Future<Patient> getPatient(String docId) async {
    DocumentSnapshot doc = await patients.doc(docId).get();
    return Patient.fromMap(doc.data() as Map<String, dynamic>, docId: doc.id);
  }

  //TODO ADD PATIENT
  Future<void> addPatient(Patient data) async {
    await patients.add(data.toMap()).then(
      (value) {
        Get.showSnackbar(
          const GetSnackBar(
            title: 'Success',
            message: "Patient added successfully",
            duration: Duration(seconds: 3),
          ),
        );
      },
    ).catchError(
      (error) {
        Get.showSnackbar(
          GetSnackBar(
            title: 'Error',
            message: "Failed to add patient: $error",
            duration: const Duration(seconds: 3),
          ),
        );
      },
    );
  }

  //TODO ADD RECORD
  Future<void> addRecordToPatient(
    String docId,
    Map<String, dynamic> newRecordData,
  ) async {
    DocumentReference patientRef =
        FirebaseFirestore.instance.collection('patients').doc(docId);

    try {
      await patientRef.update({
        'records': FieldValue.arrayUnion([newRecordData])
      });
      Get.showSnackbar(
        const GetSnackBar(
          title: 'Success',
          message: "Record added successfully!",
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      Get.showSnackbar(
        GetSnackBar(
          title: 'Error',
          message: "Failed to add record: $e",
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  //TODO DELETE PATIENT
  // void delatePatient(String docId) {
  //   FirebaseFirestore.instance.collection('patients').doc(docId).delete();
  // }
  void deletePatient(String docId) async {
    try {
      await FirebaseFirestore.instance
          .collection('patients')
          .doc(docId)
          .delete();
      Get.showSnackbar(
        const GetSnackBar(
          title: 'Success',
          message: "Patient delete successfully!",
          duration: Duration(seconds: 3),
        ),
      );
    } catch (e) {
      Get.showSnackbar(
        GetSnackBar(
          title: 'Error',
          message: "Failed to delete patient: $e",
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  //TODO EDIT PATIENT
  Future<void> editPatient(String patientId, Patient updatedData) async {
    try {
      await patients.doc(patientId).update(updatedData.toMap());
      Get.showSnackbar(
        const GetSnackBar(
          title: 'Success',
          message: "Patient updated successfully!",
          duration: Duration(seconds: 2),
        ),
      );
    } catch (error) {
      Get.showSnackbar(
        GetSnackBar(
          title: 'Error',
          message: "Failed to update patient: $error",
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  //TODO GET TOTAL PATIENTS
  Future<int> totalPatients() async {
    QuerySnapshot snapshot = await patients.get();
    return snapshot.docs.length;
  }

  //TODO GET TOTAL FEMALE PATIENTS
  Future<int> totalPatientFemale() async {
    QuerySnapshot snapshot = await patients.where('sex', isEqualTo: 'F').get();
    return snapshot.docs.length;
  }

  //TODO GET TOTAL FEMALE PATIENTS
  Future<int> totalPatientMale() async {
    QuerySnapshot snapshot = await patients.where('sex', isEqualTo: 'M').get();
    return snapshot.docs.length;
  }

  //TODO GET TOTAL RECORDS ALL PAITENTS
  Future<int> totalRecords() async {
    QuerySnapshot snapshot = await patients.get();
    int totalRecords = 0;
    snapshot.docs.forEach((doc) {
      totalRecords += (doc['records'].length as num).toInt();
    });
    return totalRecords;
  }

  //TODO GET PIN IN FIRESTORE from users collection using uid
  Future<int> getPin(String uid) async {
    DocumentSnapshot doc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    return doc['pin'] as int;
  }

  //TODO EDIT PIN IN FIRESTORE from users collection using uid and check old pin
  Future<void> editPin(String uid, int oldPin, int newPin) async {
    DocumentSnapshot doc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (doc['pin'] == oldPin) {
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'pin': newPin,
      });
      Get.showSnackbar(
        const GetSnackBar(
          title: 'Success',
          message: "Pin updated successfully!",
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      Get.showSnackbar(
        const GetSnackBar(
          title: 'Error',
          message: "Old pin is incorrect!",
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }
}
