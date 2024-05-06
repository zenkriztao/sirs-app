import 'package:get/get.dart';

import '../controllers/layout_navigation_bar_controller.dart';

class LayoutNavigationBarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LayoutNavigationBarController>(
      () => LayoutNavigationBarController(),
    );
  }
}
