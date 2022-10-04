import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jie_app_flutter/common/app_config.dart';
import 'package:jie_app_flutter/pages/login_page/login_controller.dart';
import 'package:jie_app_flutter/utils/gaps.dart';
import 'package:jie_app_flutter/utils/utils.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    String account = controller.account;

    return Scaffold(
      appBar: AppBar(
        title: const Text('登录'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 40, right: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: 100,
              height: 100,
            ),
            Gaps.vGap24,
            Container(
              padding: const EdgeInsets.only(bottom: 4),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Utils.color("#BBBBBB")),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.phone_android,
                    color: Colors.grey,
                  ),
                  Gaps.hGap10,
                  Expanded(
                    child: TextField(
                      onChanged: (value) => controller.account = value,
                      keyboardType: TextInputType.number,
                      controller: TextEditingController(text: account),
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(left: 10),
                        hintText: "请输入账号",
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
                  bottom: BorderSide(color: Utils.color("#BBBBBB")),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.remove_red_eye, color: Colors.grey),
                  Gaps.hGap10,
                  Expanded(
                    child: TextField(
                      onChanged: (value) => controller.password = value,
                      keyboardType: TextInputType.number,
                      // 密码框 隐藏输入内容
                      obscureText: true,
                      textAlignVertical: TextAlignVertical.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(6),
                        // FilteringTextInputFormatter.digitsOnly,
                        // FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                      ],
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(left: 10),
                        hintText: "请输入密码",
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
            Gaps.vGap32,
            SizedBox(
              width: 300,
              height: 48,
              child: ElevatedButton(
                onPressed: () => controller.login(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppConfig.mainColor,
                ),
                child: const Text('登录', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
