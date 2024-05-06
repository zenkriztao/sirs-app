import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../data/patient.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../../utils/constants.dart';
import '../../controllers/patient_add_controller.dart';

class TabBarRecords extends StatelessWidget {
  const TabBarRecords({
    super.key,
    required this.controller,
  });

  final PatientAddController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 12,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
      ),
      child: FutureBuilder<Patient>(
        future: controller.firestoreC.getPatient(controller.docId.value),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final data = snapshot.data?.records;
            if (data!.isNotEmpty) {
              return Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ListView.separated(
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 12),
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return SingleChildScrollView(
                              child: Column(
                                children: [
                                  Container(
                                    width: 360,
                                    height: 24,
                                    decoration: const BoxDecoration(
                                      color: colorPrimaryL,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(24),
                                        topRight: Radius.circular(24),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 360,
                                    height: 210,
                                    padding: const EdgeInsets.all(8),
                                    decoration: const BoxDecoration(),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Record Name',
                                            style: TextStyle(
                                              color: colorPrimaryL,
                                              fontSize: 16,
                                            ),
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            data[index].recordName,
                                            style: const TextStyle(
                                              color: colorTextSmall,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          const Text(
                                            'Appointment Date',
                                            style: TextStyle(
                                              color: colorPrimaryL,
                                              fontSize: 16,
                                            ),
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            DateFormat(
                                                    "EEEE, MMMM dd, yyyy 'at' HH:mm:ss, 'WIB'")
                                                .format(DateTime.parse(
                                                    data[index].createdAt)),
                                            style: const TextStyle(
                                              color: colorTextSmall,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          const Text(
                                            'Diagnosis',
                                            style: TextStyle(
                                              color: colorPrimaryL,
                                              fontSize: 16,
                                            ),
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            (data[index].diagnoses == ''
                                                ? '-'
                                                : data[index].diagnoses),
                                            style: const TextStyle(
                                              color: colorTextSmall,
                                            ),
                                            textAlign: TextAlign.justify,
                                          ),
                                          const SizedBox(height: 2),
                                          const Text(
                                            'Additional Notes',
                                            style: TextStyle(
                                              color: colorPrimaryL,
                                              fontSize: 16,
                                            ),
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            data[index].additionalNotes == ''
                                                ? '-'
                                                : data[index].additionalNotes,
                                            style: const TextStyle(
                                              color: colorTextSmall,
                                            ),
                                            textAlign: TextAlign.justify,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: colorPrimaryL,
                        // backgroundColor: colorPrimaryL,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: colorPrimaryL),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        fixedSize: Size(MediaQuery.of(context).size.width, 50),
                      ),
                      onPressed: () {
                        Get.toNamed(
                          Routes.RECORDS,
                          arguments: {
                            'docId': controller.docId.value,
                          },
                        );
                      },
                      child: const Text('Add Record'),
                    ),
                  ],
                ),
              );
            }
            return Center(
              child: Column(
                children: [
                  const Text(
                    'There is no records yet',
                    style: TextStyle(color: colorTextSmall, fontSize: 16),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: colorPrimaryL,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: colorPrimaryL),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      fixedSize: Size(MediaQuery.of(context).size.width, 50),
                    ),
                    onPressed: () {
                      Get.toNamed(
                        Routes.RECORDS,
                        arguments: {
                          'docId': controller.docId.value,
                        },
                      );
                    },
                    child: const Text('Add Record'),
                  ),
                ],
              ),
            );
          }
        }),
      ),
    );
  }
}
