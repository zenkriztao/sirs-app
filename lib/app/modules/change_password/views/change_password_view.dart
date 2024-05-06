import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import '../../../utils/constants.dart';
import '../controllers/change_password_controller.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  const ChangePasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          toolbarHeight: 80,
          elevation: 1,
          title: Text(
            'Change ${controller.pageType.value == PageType.PIN ? 'PIN' : 'Password'}',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Form(
          key: controller.formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.pageType.value == PageType.PIN
                        ? 'Your current PIN'
                        : 'Your current password',
                    style: const TextStyle(
                      color: colorDarkGrey,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Obx(() => controller.pageType.value == PageType.PIN
                      ? TextFormField(
                          showCursor: false,
                          obscureText: controller.visibilityPL.value,
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
                          controller: controller.passwordLast,
                          decoration: borderTextFormField.copyWith(
                            labelText: 'Current PIN',
                            hintText: 'Enter 6-digit PIN)',
                            prefixIcon: const Icon(
                              Icons.pin_outlined,
                              color: colorPrimaryL,
                            ),
                            suffixIcon: Listener(
                              onPointerUp: (_) =>
                                  controller.visibilityPL.value = true,
                              child: GestureDetector(
                                onLongPress: () =>
                                    controller.visibilityPL.toggle(),
                                child: Icon(
                                  controller.visibilityPL.value
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
                        )
                      //BATAS
                      : TextFormField(
                          obscureText: controller.visibilityPL.value,
                          controller: controller.passwordLast,
                          decoration: borderTextFormField.copyWith(
                            hintText: 'Enter current password',
                            labelText: 'Current Password',
                            prefixIcon: const Icon(
                              Icons.lock_outline,
                              color: colorPrimaryL,
                            ),
                            suffixIcon: InkWell(
                              onTap: () => controller.visibilityPL.toggle(),
                              child: Icon(
                                controller.visibilityPL.value
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: colorPrimaryL,
                              ),
                            ),
                          ),
                        )),
                  const SizedBox(height: 30),
                  Text(
                    controller.pageType.value == PageType.PIN
                        ? 'Your New PIN'
                        : 'Your New Password',
                    style: const TextStyle(
                      color: colorDarkGrey,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Obx(() => controller.pageType.value == PageType.PIN
                      ? TextFormField(
                          showCursor: false,
                          obscureText: controller.visibilityN.value,
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
                          controller: controller.passwordNew,
                          decoration: borderTextFormField.copyWith(
                            labelText: 'New PIN',
                            hintText: 'Enter 6-digit PIN)',
                            prefixIcon: const Icon(
                              Icons.pin_outlined,
                              color: colorPrimaryL,
                            ),
                            suffixIcon: Listener(
                              onPointerUp: (_) =>
                                  controller.visibilityN.value = true,
                              child: GestureDetector(
                                onLongPress: () =>
                                    controller.visibilityN.toggle(),
                                child: Icon(
                                  controller.visibilityN.value
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
                        )
                      //BATAS
                      : TextFormField(
                          textInputAction: TextInputAction.next,
                          controller: controller.passwordNew,
                          decoration: borderTextFormField.copyWith(
                            labelText: 'Password',
                            prefixIcon: const Icon(
                              Icons.lock_outline,
                              color: colorPrimaryL,
                            ),
                            suffixIcon: InkWell(
                              onTap: () => controller.visibilityN.toggle(),
                              child: Icon(
                                controller.visibilityN.value
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: colorPrimaryL,
                              ),
                            ),
                          ),
                          obscureText: controller.visibilityN.value,
                          validator: (value) => value!.isEmpty
                              ? 'Please enter your password.'
                              : null,
                        )),
                  const SizedBox(height: 10),
                  Obx(
                    () => controller.pageType.value == PageType.PIN
                        ? TextFormField(
                            showCursor: false,
                            obscureText: controller.visibilityCN.value,
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
                            controller: controller.passwordConfirmNew,
                            decoration: borderTextFormField.copyWith(
                              labelText: 'Confirm PIN',
                              hintText: 'Enter 6-digit PIN)',
                              prefixIcon: const Icon(
                                Icons.pin_outlined,
                                color: colorPrimaryL,
                              ),
                              suffixIcon: Listener(
                                onPointerUp: (_) =>
                                    controller.visibilityCN.value = true,
                                child: GestureDetector(
                                  onLongPress: () =>
                                      controller.visibilityCN.toggle(),
                                  child: Icon(
                                    controller.visibilityCN.value
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
                                } else if (value !=
                                    controller.passwordNew.text) {
                                  return 'PINs do not match.';
                                }
                              } else {
                                return 'Please enter your PIN.';
                              }
                              return null;
                            },
                          )
                        //BATAS
                        : TextFormField(
                            textInputAction: TextInputAction.next,
                            controller: controller.passwordConfirmNew,
                            decoration: borderTextFormField.copyWith(
                              labelText: 'Confirm Password',
                              prefixIcon: const Icon(
                                Icons.lock_outline,
                                color: colorPrimaryL,
                              ),
                              suffixIcon: InkWell(
                                onTap: () => controller.visibilityCN.toggle(),
                                child: Icon(
                                  controller.visibilityCN.value
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: colorPrimaryL,
                                ),
                              ),
                            ),
                            obscureText: controller.visibilityCN.value,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please confirm your password.';
                              } else if (value != controller.passwordNew.text) {
                                return 'Passwords do not match.';
                              }
                              return null;
                            },
                          ),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () => controller.pageType.value == PageType.PIN
                        ? controller.editPin(
                            int.parse(controller.passwordLast.text),
                            int.parse(controller.passwordNew.text),
                          )
                        : controller.resetPassword(
                            controller.passwordLast.text,
                            controller.passwordNew.text,
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
                      controller.pageType.value == PageType.PIN
                          ? 'Change PIN'
                          : 'Change Password',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
