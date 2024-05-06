import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sirs_apps/app/utils/constants.dart';
import '../controllers/records_controller.dart';

class RecordsView extends GetView<RecordsController> {
  RecordsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 80,
        leadingWidth: 70,
        foregroundColor: colorPrimaryL,
        elevation: 0.5,
        shadowColor: Colors.grey,
        title: const Text(
          'ADD RECORDS',
          style: TextStyle(
            color: colorPrimaryL,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Form(
        key: controller.fkey,
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
                  TextFormField(
                    autofillHints: const [AutofillHints.name],
                    controller: controller.recordNameC,
                    decoration: borderTextFormField.copyWith(
                      labelText: 'Record Name',
                      hintText: 'Enter record name',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter record name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: controller.diagnosisC,
                    decoration: borderTextFormField.copyWith(
                      labelText: 'Diagnosis',
                      hintText: 'Enter diagnosis',
                    ),
                    validator: (value) {
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: controller.additionalNotesC,
                    decoration: borderTextFormField.copyWith(
                      labelText: 'Additional Notes',
                      hintText: 'Enter additional notes',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                    maxLines: null,
                    minLines: 5,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                    validator: (value) {
                      return null;
                    },
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
                      'Submit',
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
      ),
    );
  }
}
