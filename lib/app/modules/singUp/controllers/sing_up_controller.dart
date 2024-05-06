import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController pinController = TextEditingController();
  final TextEditingController roleController = TextEditingController();
  final passwordVis = true.obs;
  final confirmPasswordVis = true.obs;
  final pinVisibility = true.obs;
  final regUser = true.obs;

  Future<void> signUpWithEmailAndPassword(
      String email,
      String password,
      String firstName,
      String lastName,
      int pin,
      GlobalKey<FormState> formKey,
      BuildContext context) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      try {
        EasyLoading.show();
        // Create a new user
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Get the UID of the created user
        String uid = userCredential.user!.uid;

        // Store the user information in Firestore
        await FirebaseFirestore.instance.collection('users').doc(uid).set({
          'email': email,
          'firstName': firstName,
          'lastName': lastName,
          'pin': pin,
          'role': 'reguser',
        });
        Get.back();
        EasyLoading.dismiss();
        Get.showSnackbar(const GetSnackBar(
          title: 'Account Registration Successful!',
          message: 'Congratulations! Your account registration was successful',
        ));
      } on FirebaseAuthException catch (e) {
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
    }
  }

  Future<void> signUpWithEmailAndPasswordFadmin(
      String email,
      String password,
      String firstName,
      String lastName,
      int pin,
      GlobalKey<FormState> formKey,
      BuildContext context) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      try {
        EasyLoading.show();
        // Create a new user
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Get the UID of the created user
        String uid = userCredential.user!.uid;

        // Store the user information in Firestore
        await FirebaseFirestore.instance.collection('users').doc(uid).set({
          'email': email,
          'firstName': firstName,
          'lastName': lastName,
          'pin': pin,
          'role': 'admin',
        });
        Get.back();
        EasyLoading.dismiss();
        Get.showSnackbar(const GetSnackBar(
          title: 'Account Registration Successful!',
          message: 'Congratulations! Your account registration was successful',
        ));
      } on FirebaseAuthException catch (e) {
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
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    pinController.dispose();
    roleController.dispose();

    super.onClose();
  }
}
