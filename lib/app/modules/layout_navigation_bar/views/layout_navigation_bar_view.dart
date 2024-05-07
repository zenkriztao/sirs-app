import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/constants.dart';
import '../../home/views/home_view.dart';
import '../../patient/patient/views/patient_view.dart';
import '../../profile/views/profile_view.dart';
import '../controllers/layout_navigation_bar_controller.dart';

class LayoutNavigationBarView extends GetView<LayoutNavigationBarController> {
  const LayoutNavigationBarView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LayoutNavigationBarController());

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // body: Stack(
        //   children: [
        //     PageView(
        //       physics: const NeverScrollableScrollPhysics(),
        //       controller: controller.pageController,
        //       children: [
        //         const PatientView(),
        //         HomeView(),
        //         const ProfileView(),
        //       ],
        //     ),
        //     Align(
        //       alignment: Alignment.bottomCenter,
        //       child: CurvedNavigationBar(
        //         index: controller.index.value,
        //         backgroundColor: Colors.transparent,
        //         buttonBackgroundColor: colorPrimary,
        //         color: colorPrimary,
        //         height: 60,
        //         items: [
        //           Column(
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             children: [
        //               const SizedBox(
        //                 height: 4,
        //               ),
        //               const Icon(
        //                 Icons.person_pin_outlined,
        //                 size: 28,
        //                 color: colorAccent,
        //               ),
        //               Obx(
        //                 () => controller.index.value != 0
        //                     ? Text(
        //                         'Patients',
        //                         style: Theme.of(context)
        //                             .textTheme
        //                             .bodySmall!
        //                             .copyWith(
        //                               color: Theme.of(context)
        //                                   .colorScheme
        //                                   .onPrimary,
        //                             ),
        //                       )
        //                     : const SizedBox(height: 3),
        //               ),
        //             ],
        //           ),
        //           Column(
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             children: [
        //               const SizedBox(
        //                 height: 4,
        //               ),
        //               const Icon(
        //                 Icons.local_hospital_rounded,
        //                 size: 28,
        //                 color: colorAccent,
        //               ),
        //               Obx(
        //                 () => controller.index.value != 1
        //                     ? const Text(
        //                         'Home',
        //                         style: TextStyle(
        //                           color: Colors.white,
        //                           fontWeight: FontWeight.w400,
        //                         ),
        //                       )
        //                     : const SizedBox(height: 3),
        //               ),
        //             ],
        //           ),
        //           Column(
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             children: [
        //               const SizedBox(
        //                 height: 4,
        //               ),
        //               const Icon(
        //                 Icons.menu_outlined,
        //                 size: 28,
        //                 color: colorAccent,
        //               ),
        //               Obx(
        //                 () => controller.index.value != 2
        //                     ? Text(
        //                         'Profile',
        //                         style: Theme.of(context)
        //                             .textTheme
        //                             .bodySmall!
        //                             .copyWith(
        //                               color: Theme.of(context)
        //                                   .colorScheme
        //                                   .onPrimary,
        //                             ),
        //                       )
        //                     : const SizedBox(height: 3),
        //               ),
        //             ],
        //           ),
        //         ],
        //         onTap: (index) {
        //           switch (index) {
        //             case 0:
        //               break;
        //             case 1:
        //               break;
        //             case 2:
        //               break;
        //             default:
        //           }
        //           controller.index.value = index;
        //           controller.pageController.animateToPage(
        //             index,
        //             duration: const Duration(milliseconds: 300),
        //             curve: Curves.easeOut,
        //           );
        //         },
        //       ),
        //     ),
        //   ],
        // ),

        // body: Obx(
        //   () =>
        //       controller.pages.elementAt(controller.selectedIndex.value), //New
        // ),

        body: Obx(
          () => IndexedStack(
            index: controller.selectedIndex.value,
            children: [
              const PatientView(),
              HomeView(),
              const ProfileView(),
            ],
          ),
        ),

        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            elevation: 0.5,
            onTap: controller.onItemTapped,
            selectedItemColor: colorPrimaryLL,
            currentIndex: controller.selectedIndex.value,
            iconSize: 36,
            type: BottomNavigationBarType.shifting,
            unselectedItemColor: colorPrimaryLL,
            showUnselectedLabels: false,
            selectedIconTheme:
                const IconThemeData(color: colorPrimaryLL, size: 36),
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(controller.selectedIndex == 0
                    ? Icons.person_pin_circle_rounded
                    : Icons.person_pin_circle_outlined),
                label: 'Patients',
              ),
              BottomNavigationBarItem(
                icon: Icon(controller.selectedIndex == 1
                    ? Icons.home
                    : Icons.home_outlined),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(controller.selectedIndex == 2
                    ? Icons.person_3
                    : Icons.person_3_outlined),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
