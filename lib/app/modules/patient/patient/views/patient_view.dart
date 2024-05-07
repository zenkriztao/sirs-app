import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sirs_apps/app/data/patient.dart';
import 'package:sirs_apps/app/routes/app_pages.dart';
import '../../../../utils/constants.dart';
import '../controllers/patient_controller.dart';
import 'widgets/input_pin_edit.dart';
import 'widgets/patient_info_card.dart';

class PatientView extends GetView<PatientController> {
  const PatientView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: colorPrimaryL,
        toolbarHeight: 80,
        leadingWidth: 70,
        elevation: 1,
        title: Text(
          'Patients',
          style: GoogleFonts.sora(
            color: Colors.black,
            fontSize: 24,
          ),
        ),
        actions: [
          // IconButton(
          //   onPressed: () {
          //     debugPrint('PIN: ${controller.pin.value}');
          //   },
          //   icon: Icon(Icons.text_snippet),
          // ),
          SearchAnchor(
            viewElevation: 0.5,
            viewShape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            viewLeading: Row(
              children: [
                IconButton(
                  onPressed: () {
                    controller.searchController.closeView(null);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: colorPrimaryL,
                    size: 32,
                  ),
                ),
              ],
            ),
            viewHintText: 'Enter patient name',
            headerHintStyle: GoogleFonts.sora(
              color: colorTextSmall,
              fontSize: 20,
              fontStyle: FontStyle.italic,
            ),
            dividerColor: colorPrimaryL,
            viewSurfaceTintColor: Colors.green,
            searchController: controller.searchController,
            builder: (BuildContext context, SearchController searchController) {
              return IconButton(
                  icon: const Icon(
                    Icons.search,
                    color: colorDarkGrey,
                  ),
                  onPressed: () => controller.openSearchView());
            },
            suggestionsBuilder:
                (BuildContext context, SearchController searchController) {
              if (searchController.text.isEmpty) {
                if (controller.searchHistory.isNotEmpty) {
                  return controller.getHistoryList(searchController);
                }
                return [
                  Center(
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/images/searchEmpty.gif",
                          height: 462.0,
                          width: 513.0,
                        ),
                      ],
                    ),
                  )
                ];
              }
              return controller.getSuggestions(searchController);
            },
          ),
          const SizedBox(width: 10),
          IconButton(
            onPressed: () {
              Get.toNamed(
                Routes.PATIENT_ADD,
                arguments: [
                  {
                    'pageType': PageType.TAMBAH,
                  },
                ],
              );
            },
            icon: const Icon(
              Icons.person_add_alt_1_rounded,
              color: colorDarkGrey,
              size: 32,
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: Obx(
        () => controller.isDone.value
            ? RefreshIndicator(
                onRefresh: controller.refreshData,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 2),
                  itemCount: controller.dataPatient.length,
                  itemBuilder: (context, index) {
                    final data = controller.dataPatient[index];
                    return PatientInfoCard(
                      show: true,
                      data: data,
                      onTap: () {
                        debugPrint(data.docId!);
                        controller.toPatientDetail(
                          {
                            'pageType': PageType.DETAIL,
                            'docId': data.docId,
                            'dateOfBirth': data.dateOfBirth,
                          },
                        );
                      },
                      editFunction: () {
                        Navigator.pop(context);
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            // i want to make user input pin first before edit
                            return InputPinEdit(
                              controller: controller,
                              data: data,
                              onSubmit: () async {
                                await controller.validateEditPin(
                                  int.parse(controller.pinController.text),
                                  {
                                    'pageType': PageType.EDIT,
                                    'docId': data.docId,
                                    'dateOfBirth': data.dateOfBirth,
                                  },
                                  context,
                                );
                              },
                            );
                          },
                        );
                      },
                      delateFunction: () {
                        Navigator.pop(context);
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return InputPinEdit(
                              controller: controller,
                              data: data,
                              onSubmit: () {
                                Navigator.pop(context);
                                controller.deletePatient(data.docId!);
                              },
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              )
            : const Center(
                child: CircularProgressIndicator(
                  color: colorPrimaryL,
                ),
              ),
      ),
    );
  }
}
