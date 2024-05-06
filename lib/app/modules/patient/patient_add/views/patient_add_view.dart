import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/constants.dart';
import '../controllers/patient_add_controller.dart';
import 'widgets/patient_form.dart';
import 'widgets/tab_bar_about.dart';
import 'widgets/tab_bar_records.dart';

class PatientAddView extends GetView<PatientAddController> {
  const PatientAddView({super.key});
  // const PatientAddView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: controller.pageType.value == PageType.DETAIL
          ? null
          : AppBar(
              backgroundColor: Colors.white,
              toolbarHeight: 80,
              leadingWidth: 70,
              foregroundColor: colorPrimaryL,
              elevation: 0.5,
              shadowColor: Colors.grey,
              title: Text(
                '${controller.pageType.value == PageType.EDIT ? 'UPDATE' : 'ADD'} PATIENT',
                style: const TextStyle(
                  color: colorPrimaryL,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
      body: Obx(
        () => controller.pageType.value == PageType.DETAIL
            ? Container(
                child: controller.isDone.value
                    ? Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 230,
                            child: Stack(
                              children: [
                                Container(
                                  color: colorPrimaryL,
                                  width: double.infinity,
                                  height: 180,
                                ),
                                Positioned(
                                  left: 10,
                                  top: 40,
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.arrow_back,
                                      color: Colors.white,
                                      size: 32,
                                    ),
                                    onPressed: () {
                                      Get.back();
                                    },
                                  ),
                                ),
                                Positioned(
                                  left:
                                      MediaQuery.of(context).size.width * 0.5 -
                                          70,
                                  top: 180 - 80,
                                  child: Column(
                                    children: [
                                      CircleAvatar(
                                        radius: 70,
                                        backgroundColor: Colors.white,
                                        child: Icon(
                                          controller.sex.value == "M"
                                              ? Icons.face_6
                                              : Icons.face_4,
                                          size: 100,
                                          color: colorPrimaryL,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          TabBar(
                            indicatorColor: colorPrimaryL,
                            unselectedLabelColor: colorTextSmall,
                            labelColor: colorPrimaryL,
                            tabs: const [
                              Tab(
                                text: 'About',
                              ),
                              Tab(
                                text: 'Records',
                              )
                            ],
                            controller: controller.tabController,
                            indicatorSize: TabBarIndicatorSize.tab,
                          ),
                          Expanded(
                            child: TabBarView(
                              controller: controller.tabController,
                              children: [
                                TabBarAbout(controller: controller),
                                TabBarRecords(controller: controller),
                              ],
                            ),
                          ),
                        ],
                      )
                    : const Center(child: CircularProgressIndicator()),
              )
            : PatientForm(controller: controller),
      ),
    );
  }
}
