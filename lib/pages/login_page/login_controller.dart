import 'dart:async';

import 'package:get/get.dart';

import '../../api/api.dart';
import '../../models/user_model.dart';
import '../../routers/app_pages.dart';
import '../../utils/sp_util.dart';
import '../../utils/utils.dart';
import '../main_navigation_controller.dart';

class LoginController extends GetxController {
  var account = SpUtil().localGet('account') ?? '';
  var password = '';

  Future login() async {
    if (account.isEmpty) {
      return Utils.toast('账号不能为空');
    }
    if (password.isEmpty) {
      return Utils.toast('请输入密码');
    }
    final String token = await Api.login({'account': account, 'password': password});
    SpUtil().localSet('token', token);
    SpUtil().localSet('account', account);

    final UserModel userInfo = await Api.getUserInfo();

    SpUtil().localSet('user_info', userInfo);

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
