import 'package:date_input_form_field/date_input_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../utils/constants.dart';
import '../../controllers/patient_add_controller.dart';

class PatientForm extends StatelessWidget {
  const PatientForm({
    super.key,
    required this.controller,
  });

  final PatientAddController controller;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 12,
          ),
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 24),
                TextFormField(
                  autofillHints: const [AutofillHints.name],
                  controller: controller.patientName,
                  decoration: borderTextFormField.copyWith(
                    labelText: 'Patient Name',
                    hintText: 'Enter patient name',
                    prefixIcon: const Icon(
                      Icons.person_3_outlined,
                      color: colorPrimaryL,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter patient name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Obx(() => Radio<String>(
                          value: 'M',
                          fillColor: MaterialStateColor.resolveWith(
                              (states) => colorPrimaryL),
                          groupValue: controller.sex.value,
                          onChanged: (value) {
                            controller.sex.value = value!;
                          },
                        )),
                    Text(
                      'Male',
                      style: GoogleFonts.sora(
                          color: controller.sex.value == 'M'
                              ? Colors.black
                              : colorPrimaryL),
                    ),
                    const SizedBox(width: 30),
                    Obx(() => Radio<String>(
                          value: 'F',
                          fillColor: MaterialStateColor.resolveWith(
                              (states) => colorPrimaryL),
                          groupValue: controller.sex.value,
                          onChanged: (value) {
                            controller.sex.value = value!;
                          },
                        )),
                    Text(
                      'Female',
                      style: GoogleFonts.sora(
                          color: controller.sex.value == 'F'
                              ? Colors.black
                              : colorPrimaryL),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: controller.address,
                  decoration: borderTextFormField.copyWith(
                    labelText: 'Address',
                    hintText: 'Enter address',
                    prefixIcon: const Icon(
                      Icons.location_city_rounded,
                      color: colorPrimaryL,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter address';
                    }
                    controller.address.text = value;
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                DateInputFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  format: 'dd/MM/yyyy',
                  controller: controller.dateOfBirthC,
                  validator: (value) {
                    final text = value?.$1;
                    final date = value?.$2;
                    if (date == null) {
                      if (text == null || text.isEmpty) {
                        return 'Please enter a date';
                      } else if (text.isNotEmpty) {
                        return 'Please enter a valid date\nFormat: dd/MM/yyyy\nExample: 01/01/2000';
                      }
                      return null;
                    }
                    return null;
                  },
                  onChanged: (value) {
                    final dateOfBirth = value.$2;
                    if (dateOfBirth == null) return;
                    controller.dateOfBirth = dateOfBirth;
                  },
                  decoration: borderTextFormField.copyWith(
                    labelText: 'Date of Birth',
                    hintText: 'dd/MM/yyyy',
                    prefixIcon: const Icon(
                      Icons.calendar_today_rounded,
                      color: colorPrimaryL,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () => controller.saveItem(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorPrimaryL,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: colorPrimary),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    fixedSize: Size(MediaQuery.of(context).size.width, 55),
                  ),
                  child: Text(
                    controller.pageType.value == PageType.TAMBAH
                        ? 'Submit'
                        : 'Edit',
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
