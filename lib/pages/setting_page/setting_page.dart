import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jie_app_flutter/routers/app_pages.dart';
import 'package:jie_app_flutter/utils/sp_util.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('设置'),
      ),
      body: Container(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                // show dialog
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('退出登录'),
                      content: const Text('确定退出登录吗？'),
                      actions: [
                        TextButton(
                          onPressed: () => Get.back(),
                          child: const Text('取消'),
                        ),
                        TextButton(
                          onPressed: () {
                            SpUtil().remove('user_info');
                            SpUtil().remove('token');
                            Get.offAllNamed(AppRouters.login);
                          },
                          child: const Text('确定'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text('退出登录'),
            ),
          ],
        ),
      ),
    );
  }
}
