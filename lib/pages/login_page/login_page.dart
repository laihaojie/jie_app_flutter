import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jie_app_flutter/common/app_config.dart';
import 'package:jie_app_flutter/pages/login_page/login_controller.dart';
import 'package:jie_app_flutter/utils/gaps.dart';
import 'package:jie_app_flutter/utils/utils.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('注册-登录'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: 80,
              height: 80,
            ),
            Gaps.vGap32,
            Container(
              padding: const EdgeInsets.only(bottom: 4),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Utils.color("#BBBBBB"),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    width: 20,
                    height: 20,
                  ),
                  Gaps.hGap10,
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        controller.mobile.value = value;
                      },
                      keyboardType: TextInputType.number,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(
                          top: 0,
                          bottom: 0,
                          left: 10,
                        ),
                        hintText: "请输入手机号",
                        hintStyle: TextStyle(color: Utils.color("#DCDCDC")),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 4),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Utils.color("#BBBBBB"),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    width: 20,
                    height: 20,
                  ),
                  Gaps.hGap10,
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        controller.code.value = value;
                      },
                      keyboardType: TextInputType.number,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(
                          top: 0,
                          bottom: 0,
                          left: 10,
                        ),
                        hintText: "请输入验证码",
                        hintStyle: TextStyle(color: Utils.color("#DCDCDC")),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (controller.countdownTimer != null) {
                        return;
                      }
                      controller.sendSms();
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        controller.countdownTimer != null
                            ? Utils.color("#ccc")
                            : AppConfig.mainColor,
                      ),
                      overlayColor: MaterialStateProperty.resolveWith((states) {
                        return controller.countdownTimer != null
                            ? Colors.transparent
                            : Colors.white24;
                      }),
                    ),
                    child: Text(controller.countdownTimer != null
                        ? "${controller.seconds}s"
                        : "获取验证"),
                  ),
                ],
              ),
            ),
            Gaps.vGap10,
            Gaps.vGap32,
            Center(
              child: InkWell(
                onTap: () {
                  controller.login();
                },
                child: Container(
                  // 蓝色背景的按钮
                  decoration: BoxDecoration(
                    color: AppConfig.mainColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  width: 300,
                  height: 50,
                  child: const Center(
                    child: Text(
                      '登录 | 注册',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
