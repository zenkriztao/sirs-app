import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../routes/app_pages.dart';

class ProfileController extends GetxController {
  final box = GetStorage();

  Future<void> logout() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();

    Get.offAllNamed(Routes.LOGIN);
    box.remove('email');
    box.remove('uid');
    box.remove('firstName');
    box.remove('lastName');
    box.remove('pin');
    box.remove('role');
  }

  //TODO : User Defined Function
  final firstName = ''.obs;
  final LastName = ''.obs;
  final email = ''.obs;
  final role = ''.obs;
  final pin = 0.obs;

  void initUser() {
    firstName.value = box.read('firstName');
    LastName.value = box.read('lastName');
    email.value = box.read('email');
    role.value = box.read('role');
    pin.value = box.read('pin');
  }

  final count = 0.obs;
  @override
  void onInit() {
    initUser();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
