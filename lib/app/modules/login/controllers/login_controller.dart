import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sirs_apps/app/routes/app_pages.dart';

import '../../patient/patient/views/widgets/input_pin_edit.dart';
import '../views/widgets/input_email_forgot_password.dart';

class LoginController extends GetxController {
  //TODO : send a password reset email
  final pinFormKey = GlobalKey<FormState>();
  late final TextEditingController emailFPC;
  final pinVisibility = true.obs;

  void resetPassword() {
    Get.bottomSheet(
      InputEmailForgetPassword(controller: this),
      backgroundColor: Colors.white,
    );
    emailFPC.clear();
  }

  Future<void> resetPasswordWithEmail(String email) async {
    try {
      if (email.isEmpty) {
        Get.dialog(
          AlertDialog(
            title: const Text('Sorry'),
            content: const Text('Please enter your email address'),
            actions: [
              TextButton(
                child: const Text("Back"),
                onPressed: () => Get.back(),
              ),
            ],
          ),
        );
        return;
      }
      EasyLoading.show();
      final methods =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      if (methods.isEmpty) {
        EasyLoading.dismiss();
        Get.dialog(
          AlertDialog(
            title: const Text('Sorry'),
            content: const Text('The email address is not registered.'),
            actions: [
              TextButton(
                child: const Text("Back"),
                onPressed: () => Get.back(),
              ),
            ],
          ),
        );
        return;
      }
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      EasyLoading.dismiss();
      Get.dialog(
        AlertDialog(
          title: const Text('Success'),
          content: const Text(
              'Password reset email sent successfully, check your email'),
          actions: [
            TextButton(
              child: const Text("Back"),
              onPressed: () => Get.back(),
            ),
          ],
        ),
      );
    } on FirebaseException catch (error) {
      print('error code: ${error.code}');
      print('error message: ${error.message}');
      String message;
      switch (error.code) {
        case 'invalid-email':
          message = 'The email address is not valid.';
          break;
        case 'user-not-found':
          message = 'There is no user corresponding to the given email.';
          break;
        default:
          message = 'An error occurred. Please try again.';
      }
      EasyLoading.dismiss();
      Get.dialog(
        AlertDialog(
          title: const Text('Sorry'),
          content: Text(message),
          actions: [
            TextButton(
              child: const Text("Back"),
              onPressed: () => Get.back(),
            ),
          ],
        ),
      );
    }
  }

  //TODO: Implement LoginController
  final enableLogin = true.obs;
  final isChecked = false.obs;
  final visibility = true.obs;
  final regUser = true.obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late final TextEditingController emailC;
  late final TextEditingController passwordC;
  final count = 0.obs;

  Future<void> signInWithEmailAndPassword(
    String email,
    String password,
    GlobalKey<FormState> formKey,
    BuildContext context,
  ) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      try {
        GetStorage box = GetStorage();
        EasyLoading.show();
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        final userCred = userCredential.user;
        // Assuming box is an instance of GetStorage or similar local storage

        //check if user is authorized to access the app
        final user = await FirebaseFirestore.instance
            .collection('users')
            .doc(userCred?.uid)
            .get();
        print(user['role'].runtimeType);
        if (user['role'].toString() != 'reguser' &&
            userCredential.user != null) {
          EasyLoading.dismiss();
          Get.dialog(
            AlertDialog(
              backgroundColor: Colors.white,
              title: Text(
                'Access Denied',
                style: GoogleFonts.sora(color: Colors.red),
              ),
              content: Text('You are not authorized to access this app'),
              actions: [
                TextButton(
                  child: const Text("Back"),
                  onPressed: () => Get.back(),
                ),
              ],
            ),
          );
          return;
        }
        box.write('email', userCred?.email);
        box.write('uid', userCred?.uid);
        box.write('firstName', user['firstName']);
        box.write('lastName', user['lastName']);
        box.write('pin', user['pin']);
        box.write('role', user['role']);
        // You can add more user details to store locally as per your requirement
        Get.offAllNamed(Routes.LAYOUT_NAVIGATION_BAR);
        EasyLoading.dismiss();
      } on FirebaseAuthException catch (e) {
        print('Error code: ${e.code}');
        print('Error message: ${e.message}');
        String message;
        switch (e.code) {
          case 'invalid-email':
            message = 'The email address is not valid.';
            break;
          case 'user-disabled':
            message =
                'The user corresponding to the given email has been disabled.';
            break;
          case 'user-not-found':
            message = 'There is no user corresponding to the given email.';
            break;
          case 'wrong-password':
            message = 'The password is invalid for the given email.';
            break;
          case 'wrong-password':
            message = 'The password is invalid for the given email.';
            break;
          default:
            message = 'A sign in error occurred. Please try again.';
        }
        EasyLoading.dismiss();

        Get.dialog(
          AlertDialog(
            backgroundColor: Colors.white,
            title: const Text('Sorry'),
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
        print(e); // This will print the exception to the console

        EasyLoading.dismiss();

        Get.dialog(
          AlertDialog(
            title: const Text('Sorry'),
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
    }
  }

  Future<void> signInWithEmailAndPasswordFadmin(
    String email,
    String password,
    GlobalKey<FormState> formKey,
    BuildContext context,
  ) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      try {
        GetStorage box = GetStorage();
        EasyLoading.show();
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        final userCred = userCredential.user;
        // Assuming box is an instance of GetStorage or similar local storage

        //check if user is authorized to access the app
        final user = await FirebaseFirestore.instance
            .collection('users')
            .doc(userCred?.uid)
            .get();
        print(user['role'].runtimeType);
        if (user['role'].toString() != 'admin' && userCredential.user != null) {
          EasyLoading.dismiss();
          Get.dialog(
            AlertDialog(
              backgroundColor: Colors.white,
              title: Text(
                'Access Denied',
                style: GoogleFonts.sora(color: Colors.red),
              ),
              content: const Text('You are not authorized to access this app'),
              actions: [
                TextButton(
                  child: const Text("Back"),
                  onPressed: () => Get.back(),
                ),
              ],
            ),
          );
          return;
        }
        box.write('email', userCred?.email);
        box.write('uid', userCred?.uid);
        box.write('firstName', user['firstName']);
        box.write('lastName', user['lastName']);
        box.write('pin', user['pin']);
        box.write('role', user['role']);
        // You can add more user details to store locally as per your requirement
        Get.offAllNamed(Routes.LAYOUT_NAVIGATION_BAR);
        EasyLoading.dismiss();
      } on FirebaseAuthException catch (e) {
        print('Error code: ${e.code}');
        print('Error message: ${e.message}');
        String message;
        switch (e.code) {
          case 'invalid-email':
            message = 'The email address is not valid.';
            break;
          case 'user-disabled':
            message =
                'The user corresponding to the given email has been disabled.';
            break;
          case 'user-not-found':
            message = 'There is no user corresponding to the given email.';
            break;
          case 'wrong-password':
            message = 'The password is invalid for the given email.';
            break;
          case 'wrong-password':
            message = 'The password is invalid for the given email.';
            break;
          default:
            message = 'A sign in error occurred. Please try again.';
        }
        EasyLoading.dismiss();

        Get.dialog(
          AlertDialog(
            backgroundColor: Colors.white,
            title: const Text('Sorry'),
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
        print(e); // This will print the exception to the console

        EasyLoading.dismiss();

        Get.dialog(
          AlertDialog(
            title: const Text('SorryBroo'),
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
    }
  }

  @override
  void onInit() {
    emailC = TextEditingController();
    emailFPC = TextEditingController();
    passwordC = TextEditingController();
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
