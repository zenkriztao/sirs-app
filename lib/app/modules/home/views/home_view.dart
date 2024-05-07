import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sirs_apps/app/routes/app_pages.dart';
import 'package:sirs_apps/app/utils/constants.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: colorBackgroundLL,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 90,
        leadingWidth: 70,
        elevation: 1,
        leading: Container(
          margin: const EdgeInsets.only(left: 12),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/icons/apps_logo.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              controller.firstName.value,
              style: const TextStyle(
                // color: Colors.black87,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            const Text(
              'We are happy to see you again',
              style: TextStyle(
                color: colorDarkGrey,
                fontSize: 12,
              ),
            ),
          ],
        ),
        actions: [
          InkWell(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.only(right: 24),
              child: const Icon(
                Icons.notifications,
                size: 40,
                color: colorDarkGrey,
              ),
            ),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => controller.refreshData(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      colorPrimaryL,
                      colorAccent,
                    ],
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  border: Border.fromBorderSide(
                    BorderSide(
                      color: colorAccent,
                      width: 0.5,
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        if (context.findRenderObject()?.attached ?? false) {
                          controller.patientC.searchController.openView();
                        }
                      },
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.search,
                                color: colorAccent,
                                size: 36,
                              ),
                              SizedBox(width: 20),
                              Text(
                                'Search',
                                style: TextStyle(
                                  color: colorAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                ),
                              ),
                              Spacer(),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: colorPrimaryL,
                                size: 32,
                                weight: 20,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  border: Border.fromBorderSide(
                    BorderSide(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                ),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: RichText(
                      text: TextSpan(
                    text: 'Not found? ',
                    style: const TextStyle(
                      color: colorDarkGrey,
                      fontSize: 12,
                    ),
                    children: [
                      TextSpan(
                        text: 'Add new patient',
                        style: const TextStyle(
                          color: colorPrimaryL,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.toNamed(
                              Routes.PATIENT_ADD,
                              arguments: [
                                {
                                  'pageType': PageType.TAMBAH,
                                },
                              ],
                            );
                          },
                      ),
                    ],
                  )),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                height: 320,
                width: double.infinity,
                decoration: const BoxDecoration(
                  // color: Colors.amber,
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  border: Border.fromBorderSide(
                    BorderSide(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      'Medical Record Statitic',
                      style: TextStyle(
                        fontSize: 21,
                        color: colorDarkGrey,
                        // color: colorPrimaryL,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                ),
                                border: Border.fromBorderSide(
                                  BorderSide(
                                    color: colorPrimaryL,
                                    width: 2,
                                  ),
                                ),
                              ),
                              width: 140,
                              height: 116,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Total Record',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: colorDarkGrey,
                                    ),
                                  ),
                                  Obx(
                                    () => Text(
                                      '${controller.totalRecord.value}',
                                      style: const TextStyle(
                                        fontSize: 48,
                                        color: colorPrimaryL,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                color: colorPrimaryL,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                ),
                                border: Border(
                                  bottom: BorderSide(
                                      color: colorPrimaryL, width: 2),
                                  right: BorderSide(
                                      color: colorPrimaryL, width: 2),
                                  top: BorderSide(
                                      color: colorPrimaryL, width: 2),
                                ),
                              ),
                              height: 116,
                              width: 30,
                              child: const Center(
                                child: Icon(
                                  Icons.keyboard_arrow_right_sharp,
                                  color: Colors.white,
                                  size: 32,
                                  weight: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                ),
                                border: Border.fromBorderSide(
                                  BorderSide(
                                    color: colorPrimaryL,
                                    width: 2,
                                  ),
                                ),
                              ),
                              width: 140,
                              height: 116,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Total Patient',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: colorDarkGrey,
                                    ),
                                  ),
                                  Obx(
                                    () => Text(
                                      '${controller.totalPatients.value}',
                                      style: const TextStyle(
                                        fontSize: 48,
                                        color: colorPrimaryL,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                color: colorPrimaryL,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                ),
                                border: Border(
                                  bottom: BorderSide(
                                      color: colorPrimaryL, width: 2),
                                  right: BorderSide(
                                      color: colorPrimaryL, width: 2),
                                  top: BorderSide(
                                      color: colorPrimaryL, width: 2),
                                ),
                              ),
                              height: 116,
                              width: 30,
                              child: const Center(
                                child: Icon(
                                  Icons.keyboard_arrow_right_sharp,
                                  color: Colors.white,
                                  size: 32,
                                  weight: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                ),
                                border: Border.fromBorderSide(
                                  BorderSide(
                                    color: colorPrimaryL,
                                    width: 2,
                                  ),
                                ),
                              ),
                              width: 140,
                              height: 116,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Male',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: colorDarkGrey,
                                    ),
                                  ),
                                  Obx(
                                    () => Text(
                                      '${controller.totalMale.value}',
                                      style: const TextStyle(
                                        fontSize: 48,
                                        color: colorPrimaryL,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                color: colorPrimaryL,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                ),
                                border: Border(
                                  bottom: BorderSide(
                                      color: colorPrimaryL, width: 2),
                                  right: BorderSide(
                                      color: colorPrimaryL, width: 2),
                                  top: BorderSide(
                                      color: colorPrimaryL, width: 2),
                                ),
                              ),
                              height: 116,
                              width: 30,
                              child: const Center(
                                child: Icon(
                                  Icons.keyboard_arrow_right_sharp,
                                  color: Colors.white,
                                  size: 32,
                                  weight: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                ),
                                border: Border.fromBorderSide(
                                  BorderSide(
                                    color: colorPrimaryL,
                                    width: 2,
                                  ),
                                ),
                              ),
                              width: 140,
                              height: 116,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Female',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: colorDarkGrey,
                                    ),
                                  ),
                                  Obx(
                                    () => Text(
                                      '${controller.totalFemale.value}',
                                      style: const TextStyle(
                                        fontSize: 48,
                                        color: colorPrimaryL,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                color: colorPrimaryL,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                ),
                                border: Border(
                                  bottom: BorderSide(
                                      color: colorPrimaryL, width: 2),
                                  right: BorderSide(
                                      color: colorPrimaryL, width: 2),
                                  top: BorderSide(
                                      color: colorPrimaryL, width: 2),
                                ),
                              ),
                              height: 116,
                              width: 30,
                              child: const Center(
                                child: Icon(
                                  Icons.keyboard_arrow_right_sharp,
                                  color: Colors.white,
                                  size: 32,
                                  weight: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
