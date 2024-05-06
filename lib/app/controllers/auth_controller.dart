import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sirs_apps/app/routes/app_pages.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  Stream<User?> get streamAuthStatus => auth.authStateChanges();

  // void login(String email, String password) async {
  //   try {
  //     await auth.signInWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );
  //     Get.offAllNamed(Routes.HOME);
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'user-not-found') {
  //       if (kDebugMode) {
  //         print('No user found for that email.');
  //       }
  //     } else if (e.code == 'wrong-password') {
  //       if (kDebugMode) {
  //         print('Wrong password provided for that user.');
  //       }
  //     }
  //   }
  // }

  void login(String email, String password) async {
    GetStorage box = GetStorage();
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Assuming box is an instance of GetStorage or similar local storage
      box.write('email', userCredential.user?.email);
      box.write('uid', userCredential.user?.uid);

      // You can add more user details to store locally as per your requirement

      Get.offAllNamed(Routes.LAYOUT_NAVIGATION_BAR);
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      if (e.code == 'user-not-found') {
        // GetSnackBar('Gagal', 'No user found for that email.', 400);
      } else if (e.code == 'wrong-password') {
        // showSnackBar('Gagal', 'Wrong password provided for that user.', 400);
      }
    }
  }

  void logout() async {
    GetStorage box = GetStorage();

    await FirebaseAuth.instance.signOut(); // Add this line
    Get.offAllNamed(Routes.LOGIN);
    box.remove('email');
    box.remove('uid');
    box.remove('firstName');
    box.remove('lastName');
    box.remove('pin');
    box.remove('role');
  }
}
