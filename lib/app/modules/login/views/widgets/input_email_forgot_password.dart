import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sirs_apps/app/modules/login/controllers/login_controller.dart';

import '../../../../utils/constants.dart';

class InputEmailForgetPassword extends StatelessWidget {
  const InputEmailForgetPassword({
    required this.controller,
  });

  final LoginController controller;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) => controller.emailC.clear(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Center(
          child: Form(
            key: controller.pinFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                const Text(
                  'Enter your Email to reset your password',
                  style: TextStyle(
                    color: colorPrimaryL,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
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
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: colorPrimaryL,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: colorPrimary),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    fixedSize: Size(MediaQuery.of(context).size.width, 55),
                  ),
                  onPressed: () async {
                    if (controller.pinFormKey.currentState!.validate()) {
                      controller.pinFormKey.currentState!.save();
                      await controller
                          .resetPasswordWithEmail(controller.emailFPC.text);
                    }
                  },
                  child: const Text(
                    'Continue',
                    style: TextStyle(fontSize: 16),
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
