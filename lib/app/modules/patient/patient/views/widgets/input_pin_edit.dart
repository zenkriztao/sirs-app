import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../../data/patient.dart';
import '../../../../../utils/constants.dart';
import '../../controllers/patient_controller.dart';

class InputPinEdit extends StatelessWidget {
  const InputPinEdit({
    required this.controller,
    required this.data,
    required this.onSubmit,
  });

  final PatientController controller;
  final Patient data;
  final void Function()? onSubmit;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) => controller.pinController.clear(),
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
                  'Enter your PIN to continue',
                  style: TextStyle(
                    color: colorPrimaryL,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Obx(
                  () => TextFormField(
                    cursorWidth: 0,
                    showCursor: true,
                    obscureText: controller.pinVisibility.value,
                    obscuringCharacter: '*',
                    style: const TextStyle(
                      letterSpacing: 24,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: colorPrimaryL,
                    ),
                    textAlign: TextAlign.center,
                    textInputAction: TextInputAction.done,
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
                      if (value == null || value.isEmpty) {
                        return 'Please enter a pin';
                      }
                      try {
                        int.parse(value);
                      } catch (e) {
                        return 'Please enter a valid number';
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
                  onPressed:
                      controller.pinController.text.isEmpty ? null : onSubmit,
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
