import 'dart:async';

import 'package:get/get.dart';
import 'package:jie_app_flutter/api/api.dart';
import 'package:jie_app_flutter/models/user_model.dart';
import 'package:jie_app_flutter/utils/sp_util.dart';
import 'package:jie_app_flutter/utils/utils.dart';

class LoginController extends GetxController {
  var mobile = ''.obs;
  var code = ''.obs;
  Timer? countdownTimer;
  var seconds = 60.obs;

  Future sendSms() async {
    if (mobile.value.isEmpty) {
      return Utils.toast("请输入手机号");
    }
    if (!Utils.testMobile(mobile.value)) {
      return Utils.toast("手机号格式不正确");
    }

    await Api.sendSms({
      "mobile": mobile,
      "type": "register",
      "apiType": "app",
    });

    Utils.toast("发送成功");
    if (countdownTimer != null) {
      return;
    }
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds > 0) {
        seconds.value--;
      } else {
        countdownTimer?.cancel();
        countdownTimer = null;
      }
    });
  }

  Future login() async {
    if (mobile.value.isEmpty) {
      return Utils.toast("请输入手机号");
    }
    if (!Utils.testMobile(mobile.value)) {
      return Utils.toast("手机号格式不正确");
    }
    if (code.isEmpty) {
      return Utils.toast("请输入验证码");
    }
    String token = await Api.login({
      "mobile": mobile,
      "code": code,
      "apiType": "app",
    });
    SpUtil().localSet("token", token);

    UserModel userInfo = await Api.getUserInfo();

    SpUtil().localSet("user_info", userInfo);

    Get.back();
  }
}

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
  }
}
