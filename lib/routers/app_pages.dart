import 'package:flutter/cupertino.dart';
import 'package:jie_app_flutter/pages/detail_page/detail_controller.dart';
import 'package:jie_app_flutter/pages/detail_page/detail_page.dart';
import 'package:jie_app_flutter/pages/detail_page/test1_page.dart';
import 'package:jie_app_flutter/pages/detail_page/test2_page.dart';
import 'package:jie_app_flutter/pages/login_page/login_controller.dart';
import 'package:jie_app_flutter/pages/login_page/login_page.dart';
import 'package:jie_app_flutter/pages/main_navigation_controller.dart';
import 'package:jie_app_flutter/pages/main_navigation.dart';
import 'package:get/get.dart';
import 'package:jie_app_flutter/pages/setting_page/setting_page.dart';
part 'app_routers.dart';

class AppPages {
  static const initial = AppRouters.main;
  static final routes = [
    GetPage(
      name: AppRouters.main,
      page: () => const MainNavigation(),
      binding: MainNavigationBinding(),
      children: const [
        // GetPage(
        //   name: AppRouters.home,
        //   page: () => const HomePage(),
        // ),
        // GetPage(
        //   name: AppRouters.me,
        //   page: () => const MePage(),
        // ),
        // GetPage(
        //   name: AppRouters.challenge,
        //   page: () => ChallengePage(),
        //   binding: ChallengeBinding(),
        // ),
      ],
    ),
    GetPage(
      name: AppRouters.login,
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRouters.detail,
      page: () => DetailPage(),
      binding: DetailBinding(),
    ),
    GetPage(
      name: AppRouters.setting,
      page: () => const SettingPage(),
    ),
    GetPage(name: AppRouters.test1, page: () => const Test1Page()),
    GetPage(name: AppRouters.test2, page: () => const Test2Page()),
  ];
}
