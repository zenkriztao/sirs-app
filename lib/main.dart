import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sirs_apps/app/controllers/auth_controller.dart';

import 'app/routes/app_pages.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
  configLoading();
}

class MyApp extends StatelessWidget {
  final autC = Get.put(AuthController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    // return StreamBuilder<User?>(
    //   stream: autC.streamAuthStatus,
    //   builder: (context, snapshot) {
    //     print('SNAPSHOT ${snapshot.data}');
    //     if (snapshot.connectionState == ConnectionState.active) {
    //       print('SNAPSHOT ${snapshot.data}');
    //       return GetMaterialApp(
    //         title: "Application",
    //         initialRoute: snapshot.data != null
    //             ? Routes.LAYOUT_NAVIGATION_BAR
    //             : Routes.LOGIN,
    //         getPages: AppPages.routes,
    //         // home: snapshot.data != null ? HomeView() : LoginView(),
    //         builder: EasyLoading.init(),
    //       );
    //     }
    //     return const LoadingView();
    //   },
    // );

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute: checkLogin() ? Routes.LAYOUT_NAVIGATION_BAR : Routes.LOGIN,
      // home: checkLogin() ? HomeView() : LoginView(),
      getPages: AppPages.routes,
      builder: EasyLoading.init(),
    );
  }
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = Duration(seconds: 3)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.light
    ..userInteractions = false;
}

bool checkLogin() {
  var box = GetStorage();

  if (!GetUtils.isNull(box.read('email')) &&
      !GetUtils.isNull(box.read('uid'))) {
    return true;
  } else {
    return false;
  }
}
