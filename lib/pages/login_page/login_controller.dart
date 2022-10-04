import 'dart:async';

import 'package:get/get.dart';
import 'package:jie_app_flutter/api/api.dart';
import 'package:jie_app_flutter/models/user_model.dart';
import 'package:jie_app_flutter/pages/main_navigation_controller.dart';
import 'package:jie_app_flutter/routers/app_pages.dart';
import 'package:jie_app_flutter/utils/sp_util.dart';
import 'package:jie_app_flutter/utils/utils.dart';

class LoginController extends GetxController {
  var account = SpUtil().localGet('account') ?? '';
  var password = '';

  Future login() async {
    if (account.isEmpty) {
      return Utils.toast("账号不能为空");
    }
    if (password.isEmpty) {
      return Utils.toast("请输入密码");
    }
    String token = await Api.login({"account": account, "password": password});
    SpUtil().localSet("token", token);
    SpUtil().localSet('account', account);

    UserModel userInfo = await Api.getUserInfo();

    SpUtil().localSet("user_info", userInfo);

    try {
      Get.find<MainNavigationController>();
      Get.back();
    } catch (e) {
      Get.offAllNamed(AppRouters.main);
    }
  }
}

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
  }
}
