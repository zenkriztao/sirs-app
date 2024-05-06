import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sirs_apps/app/utils/constants.dart';
import '../controllers/sing_up_controller.dart';

class SingUpView extends GetView<SignUpController> {
  const SingUpView({Key? key}) : super(key: key);
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
                  child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(Icons.arrow_back),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Create Your\nAppsName Account!',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  height: 1.2),
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

      body: SingleChildScrollView(
        child: Form(
          key: controller.formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              children: [
                Row(
                  children: [
                    const Spacer(),
                    Obx(
                      () => InkWell(
                        splashColor: Colors.transparent,
                        onTap: () {
                          controller.regUser.toggle();
                        },
                        child: Text(
                          controller.regUser.value
                              ? 'Sign up as admin?'
                              : 'Sign up as user?',
                          style: const TextStyle(
                            color: colorPrimaryL,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: controller.firstNameController,
                        decoration: borderTextFormField.copyWith(
                          labelText: 'First Name',
                          prefixIcon: const Icon(
                            Icons.person_outline,
                            color: colorPrimaryL,
                          ),
                        ),
                        validator: (value) =>
                            value!.isEmpty ? 'First name is required.' : null,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: controller.lastNameController,
                        decoration: borderTextFormField.copyWith(
                            labelText: 'Last Name'),
                        validator: (value) =>
                            value!.isEmpty ? 'Last name is required.' : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  controller: controller.emailController,
                  decoration: borderTextFormField.copyWith(
                    labelText: 'Email',
                    prefixIcon: const Icon(
                      Icons.email_outlined,
                      color: colorPrimaryL,
                    ),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter your email.' : null,
                ),
                const SizedBox(height: 10),
                Obx(() => TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: controller.passwordController,
                      decoration: borderTextFormField.copyWith(
                        labelText: 'Password',
                        prefixIcon: const Icon(
                          Icons.lock_outline,
                          color: colorPrimaryL,
                        ),
                        suffixIcon: InkWell(
                          onTap: () => controller.passwordVis.toggle(),
                          child: Icon(
                            controller.passwordVis.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: colorPrimaryL,
                          ),
                        ),
                      ),
                      obscureText: controller.passwordVis.value,
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter your password.' : null,
                    )),
                const SizedBox(height: 10),
                Obx(
                  () => TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: controller.confirmPasswordController,
                    decoration: borderTextFormField.copyWith(
                      labelText: 'Confirm Password',
                      prefixIcon: const Icon(
                        Icons.lock_outline,
                        color: colorPrimaryL,
                      ),
                      suffixIcon: InkWell(
                        onTap: () => controller.confirmPasswordVis.toggle(),
                        child: Icon(
                          controller.confirmPasswordVis.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: colorPrimaryL,
                        ),
                      ),
                    ),
                    obscureText: controller.confirmPasswordVis.value,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please confirm your password.';
                      } else if (value != controller.passwordController.text) {
                        return 'Passwords do not match.';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Obx(
                  () => TextFormField(
                    showCursor: false,
                    obscureText: controller.pinVisibility.value,
                    obscuringCharacter: '*',
                    style: const TextStyle(
                      letterSpacing: 24,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: colorPrimaryL,
                    ),
                    textAlign: TextAlign.center,
                    textInputAction: TextInputAction.next,
                    keyboardType: const TextInputType.numberWithOptions(
                        decimal: false, signed: false),
                    controller: controller.pinController,
                    decoration: borderTextFormField.copyWith(
                      labelText: 'PIN',
                      hintText: 'Enter 6-digit PIN)',
                      prefixIcon: const Icon(
                        Icons.pin_outlined,
                        color: colorPrimaryL,
                      ),
                      suffixIcon: Listener(
                        onPointerUp: (_) =>
                            controller.pinVisibility.value = true,
                        child: GestureDetector(
                          onLongPress: () => controller.pinVisibility.toggle(),
                          child: Icon(
                            controller.pinVisibility.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: colorPrimaryL,
                          ),
                        ),
                      ),
                      hintStyle: TextStyle(
                        letterSpacing: 1,
                        fontSize: 16,
                        // fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: colorPrimaryL.withOpacity(0.7),
                      ),
                    ),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(
                          6) // Limit the input length to 6 digits
                    ],
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        if (value.length != 6) {
                          return 'PIN must be exactly 6 digits.';
                        }
                        final number = int.tryParse(value);
                        if (number == null) {
                          return 'Please enter a valid PIN.';
                        }
                      } else {
                        return 'Please enter your PIN.';
                      }
                      return null;
                    },
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
                  onPressed: () {
                    int? pin = int.tryParse(controller.pinController.text);
                    if (pin == null) {
                      // Handle the error, e.g., show a dialog or a snackbar
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please enter a valid PIN.'),
                        ),
                      );
                    } else {
                      controller.regUser.value
                          ? controller.signUpWithEmailAndPassword(
                              controller.emailController.text,
                              controller.passwordController.text,
                              controller.firstNameController.text,
                              controller.lastNameController.text,
                              pin,
                              controller.formKey,
                              context,
                            )
                          : controller.signUpWithEmailAndPasswordFadmin(
                              controller.emailController.text,
                              controller.passwordController.text,
                              controller.firstNameController.text,
                              controller.lastNameController.text,
                              pin,
                              controller.formKey,
                              context,
                            );
                    }
                  },
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      // ],
      // ),
    );
  }
}
