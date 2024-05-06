import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sirs_apps/app/controllers/firestore_controller.dart';
import 'package:sirs_apps/app/utils/constants.dart';

class ChangePasswordController extends GetxController {
  final box = GetStorage();
  //TODO: Implement ChangePasswordController
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final pageType = PageType.CHANGEPASSWORD.obs;

  Future<void> resetPassword(String currentPassword, String newPassword) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      final user = FirebaseAuth.instance.currentUser;
      if (user != null && user.email != null) {
        final cred = EmailAuthProvider.credential(
            email: user.email!, password: currentPassword);

        try {
          EasyLoading.show();
          await user.reauthenticateWithCredential(cred);
          await user.updatePassword(newPassword);
          Get.back();
          EasyLoading.dismiss();
          Get.showSnackbar(const GetSnackBar(
            title: 'Password Changed!',
            message: 'Congratulations! Your password has been changed',
          ));
        } on FirebaseAuthException catch (e) {
          print('Error Code: ${e.code}');
          print('Error Message: ${e.message}');
          String message;
          if (e.code == 'weak-password') {
            message = 'The password provided is too weak.';
          } else if (e.code == 'email-already-in-use') {
            message = 'The account already exists for that email.';
          } else {
            message = 'Something went wrong. Please try again later.';
          }
          EasyLoading.dismiss();
          Get.dialog(
            AlertDialog(
              title: const Text('Error'),
              content: Text(message),
              actions: [
                TextButton(
                  child: const Text("Back"),
                  onPressed: () => Get.back(),
                ),
              ],
            ),
          );
        } catch (e) {
          EasyLoading.dismiss();
          Get.dialog(
            AlertDialog(
              title: const Text('Error'),
              content:
                  Text('An unexpected error occurred. Please try again later.'),
              actions: [
                TextButton(
                  child: const Text("Back"),
                  onPressed: () => Get.back(),
                ),
              ],
            ),
          );
        }
      } else {
        // Handle the situation when user or user.email is null
      }
    }
  }

//Just Save
// Future<void> editPin(int oldPin, int newPin) async {
//   try {
//     EasyLoading.show();
//     final uid = box.read('uid');
//     DocumentSnapshot doc =
//         await FirebaseFirestore.instance.collection('users').doc(uid).get();
//     if (doc['pin'] == oldPin) {
//       await FirebaseFirestore.instance.collection('users').doc(uid).update({
//         'pin': newPin,
//       });
//       Get.back();
//       EasyLoading.dismiss();
//       Get.showSnackbar(
//         const GetSnackBar(
//           backgroundColor: Colors.green,
//           title: 'Success',
//           message: "Pin updated successfully!",
//           duration: Duration(seconds: 2),
//         ),
//       );
//     } else {
//       EasyLoading.dismiss();
//       Get.showSnackbar(
//         const GetSnackBar(
//           backgroundColor: Colors.red,
//           title: 'Error',
//           message: "Old pin is incorrect!",
//           duration: const Duration(seconds: 2),
//         ),
//       );
//     }
//   } catch (e) {
//     EasyLoading.dismiss();
//     Get.showSnackbar(
//       const GetSnackBar(
//         backgroundColor: Colors.red,
//         title: 'Error',
//         message: "An unexpected error occurred!",
//         duration: const Duration(seconds: 2),
//       ),
//     );
//   }
// }

  //TODO EDIT PIN IN FIRESTORE from users collection using uid and check old pin

  Future<void> editPin(int oldPin, int newPin) async {
    try {
      EasyLoading.show();
      final uid = box.read('uid');
      DocumentSnapshot doc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (doc['pin'] == oldPin) {
        await FirebaseFirestore.instance.collection('users').doc(uid).update({
          'pin': newPin,
        });
        Get.back();
        EasyLoading.dismiss();
        Get.showSnackbar(
          const GetSnackBar(
            title: 'Success',
            message: "Pin updated successfully!",
            duration: Duration(seconds: 2),
          ),
        );
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

  final visibilityPL = true.obs;
  final visibilityN = true.obs;
  final visibilityCN = true.obs;
  late final TextEditingController passwordLast;
  late final TextEditingController passwordNew;
  late final TextEditingController passwordConfirmNew;

  final count = 0.obs;
  @override
  void onInit() {
    pageType.value = Get.arguments[0]['pageType'];
    passwordLast = TextEditingController();
    passwordNew = TextEditingController();
    passwordConfirmNew = TextEditingController();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    passwordLast.dispose();
    passwordNew.dispose();
    passwordConfirmNew.dispose();
    super.onClose();
  }

  void increment() => count.value++;
}
