import 'package:get/get.dart';

import '../modules/about/bindings/about_binding.dart';
import '../modules/about/views/about_view.dart';
import '../modules/change_password/bindings/change_password_binding.dart';
import '../modules/change_password/views/change_password_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/layout_navigation_bar/bindings/layout_navigation_bar_binding.dart';
import '../modules/layout_navigation_bar/views/layout_navigation_bar_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/patient/patient/bindings/patient_binding.dart';
import '../modules/patient/patient/views/patient_view.dart';
import '../modules/patient/patient_add/bindings/patient_add_binding.dart';
import '../modules/patient/patient_add/views/patient_add_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/records/records/bindings/records_binding.dart';
import '../modules/records/records/views/records_view.dart';
import '../modules/singUp/bindings/sing_up_binding.dart';
import '../modules/singUp/views/sing_up_view.dart';
import '../modules/user_details/bindings/user_details_binding.dart';
import '../modules/user_details/views/user_details_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;
  static const LOGIN = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
      transition: Transition.leftToRight,
      transitionDuration: Duration(microseconds: 1000),
    ),
    GetPage(
      name: _Paths.RECORDS,
      page: () => RecordsView(),
      binding: RecordsBinding(),
    ),
    GetPage(
      name: _Paths.PATIENT,
      page: () => const PatientView(),
      binding: PatientBinding(),
    ),
    GetPage(
      name: _Paths.PATIENT_ADD,
      page: () => const PatientAddView(),
      binding: PatientAddBinding(),
    ),
    GetPage(
      name: _Paths.LAYOUT_NAVIGATION_BAR,
      page: () => const LayoutNavigationBarView(),
      binding: LayoutNavigationBarBinding(),
    ),
    GetPage(
        name: _Paths.SING_UP,
        page: () => const SingUpView(),
        binding: SingUpBinding(),
        transition: Transition.leftToRight,
        transitionDuration: Duration(microseconds: 1000)),
    GetPage(
      name: _Paths.USER_DETAILS,
      page: () => const UserDetailsView(),
      binding: UserDetailsBinding(),
    ),
    GetPage(
      name: _Paths.CHANGE_PASSWORD,
      page: () => const ChangePasswordView(),
      binding: ChangePasswordBinding(),
    ),
    GetPage(
      name: _Paths.ABOUT,
      page: () => const AboutView(),
      binding: AboutBinding(),
    ),
  ];
}
