import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sirs_apps/app/controllers/auth_controller.dart';
import 'package:sirs_apps/app/utils/constants.dart';

import '../../../routes/app_pages.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  final authC = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: colorPrimaryL,
        toolbarHeight: 150,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 23,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                foregroundColor: Colors.white,
                backgroundColor: colorPrimaryL,
                radius: 22,
                child: Center(
                  child: Icon(Icons.sign_language),
                ),
              ),
            ),
            SizedBox(height: 24),
            Text(
              'Sign in to Your\nAppsName Account!',
              style: GoogleFonts.sora(
                  color: Colors.white, fontSize: 24, height: 1.2, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Obx(() => Image.asset(
                    controller.regUser.value
                        ? 'assets/icons/reguser.png'
                        : 'assets/icons/administrator.png',
                    width: 70,
                    height: 70,
                    color: colorAccent,
                  )),
            ),
          ),
          const SizedBox(width: 10)
        ],
      ),
      body: Form(
        key: controller.formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Obx(() => Image.asset(
                    controller.regUser.value
                        ? 'assets/images/patient.png'
                        : 'assets/images/doctor.png',
                    width: 150,
                  )),
                    const Spacer(),
                    Obx(
                      () => InkWell(
                        splashColor: Colors.transparent,
                        onTap: () {
                          controller.regUser.toggle();
                        },
                        child: Text(
                          controller.regUser.value
                              ? 'Login as admin?'
                              : 'Login as user?',
                          style: GoogleFonts.sora(
                            color: colorPrimaryL,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: controller.emailC,
                  decoration: borderTextFormField.copyWith(
                    hintText: 'E-mail ID',
                    prefixIcon: const Icon(
                      Icons.email_outlined,
                      color: colorPrimaryL,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Obx(
                  () => TextFormField(
                    obscureText: controller.visibility.value,
                    controller: controller.passwordC,
                    decoration: borderTextFormField.copyWith(
                      hintText: 'Enter passowrd',
                      labelText: 'Password',
                      prefixIcon: const Icon(
                        Icons.lock_outline,
                        color: colorPrimaryL,
                      ),
                      suffixIcon: InkWell(
                        onTap: () => controller.visibility.toggle(),
                        child: Icon(
                          controller.visibility.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: colorPrimaryL,
                        ),
                      ),
                    ),
                  ),
                ),
                // const SizedBox(height: 4),
                Row(
                  children: [
                    Obx(
                      () => Checkbox(
                        value: controller.isChecked.value,
                        checkColor: colorPrimaryL,
                        activeColor: Colors.white,
                        focusColor: colorPrimaryL,
                        side: const BorderSide(color: colorPrimaryL, width: 2),
                        onChanged: (_) {
                          controller.isChecked.value =
                              !controller.isChecked.value;
                        },
                      ),
                    ),
                    const Text('Remember me'),
                    const Spacer(),
                    TextButton(
                      onPressed: () => controller.resetPassword(),
                      child: Text(
                        'Forgot password?',
                        style: GoogleFonts.sora(color: colorPrimaryL),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () => controller.regUser.value
                      ? controller.signInWithEmailAndPassword(
                          controller.emailC.text.trim(),
                          controller.passwordC.text.trim(),
                          controller.formKey,
                          context,
                        )
                      : controller.signInWithEmailAndPasswordFadmin(
                          controller.emailC.text.trim(),
                          controller.passwordC.text.trim(),
                          controller.formKey,
                          context,
                        ),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: colorPrimaryL,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: colorPrimary),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    fixedSize: Size(MediaQuery.of(context).size.width, 55),
                  ),
                  child: Text(
                    'Login',
                    style: GoogleFonts.sora(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 30),
                RichText(
                  text: TextSpan(
                    text: 'Don\'t have account?  ',
                    style: GoogleFonts.sora(
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: 'Sign Up',
                        style: GoogleFonts.sora(color: colorPrimaryL, fontWeight: FontWeight.bold),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.toNamed(Routes.SING_UP);
                          },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
