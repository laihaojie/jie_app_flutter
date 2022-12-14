// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../api/api.dart';
import '../webview_page/webview_page.dart';
import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage(this.tabbarController, {super.key});
  final TabController tabbarController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                final res = await Api.test();
                print(res);
              },
              child: const Text('测试'),
            ),
            for (int idx = 0; idx < controller.websiteList.length; idx++)
              ElevatedButton(
                onPressed: () {
                  Get.to(
                    () => WebviewPage(url: controller.websiteList[idx]['url']!),
                  );
                },
                child: Text(controller.websiteList[idx]['name']!),
              ),
          ],
        ),
      ),
    );
  }
}
