import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sirs_apps/app/routes/app_pages.dart';

import '../../../utils/constants.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorAccent,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: colorPrimaryL,
        toolbarHeight: 80,
        elevation: 1,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, top: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: colorPrimaryL,
                      radius: 18,
                      child: Center(
                        child: Text(
                          '${controller.firstName.value[0].toUpperCase()}${controller.LastName.value[0].toUpperCase()}',
                          style: const TextStyle(
                            color: colorAccent,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          '${controller.firstName.value} ${controller.LastName.value}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          controller.email.value,
                          style: const TextStyle(
                            color: colorDarkGrey,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.edit,
                          size: 36,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Account',
                      style: TextStyle(
                        fontSize: 20,
                        color: colorDarkGrey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      height: 30,
                      width: 70,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            colorPrimaryL,
                            Colors.amber,
                            colorAccent,
                            colorPrimaryL,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          controller.role.value == 'admin' ? 'Admin' : 'User',
                          style: TextStyle(
                            fontSize: 16,
                            color: colorPrimaryL.withOpacity(0.8),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 18, right: 18),
            height: 240,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: 8),
                MenuProfile(
                  title: 'Change Password',
                  icon: Icons.lock,
                  onTap: () {
                    Get.toNamed(
                      Routes.CHANGE_PASSWORD,
                      arguments: [
                        {
                          'pageType': PageType.CHANGEPASSWORD,
                        }
                      ],
                    );
                  },
                ),
                const SizedBox(height: 8),
                MenuProfile(
                  title: 'Change Pin',
                  icon: Icons.pin,
                  onTap: () {
                    Get.toNamed(
                      Routes.CHANGE_PASSWORD,
                      arguments: [
                        {
                          'pageType': PageType.PIN,
                        }
                      ],
                    );
                  },
                ),
                const SizedBox(height: 8),
                MenuProfile(
                  title: 'About',
                  icon: Icons.info,
                  onTap: () {},
                ),
                const SizedBox(height: 8),
                MenuProfile(
                  title: 'Logout',
                  icon: Icons.logout,
                  onTap: () async {
                    await controller.logout();
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class MenuProfile extends StatelessWidget {
  const MenuProfile({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });
  final String title;
  final IconData icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, color: colorDarkGrey, size: 32),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 19,
              color: colorDarkGrey,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          const Icon(
            Icons.arrow_forward_ios,
            color: colorTextSmall,
            size: 24,
          ),
        ],
      ),
    );
  }
}
