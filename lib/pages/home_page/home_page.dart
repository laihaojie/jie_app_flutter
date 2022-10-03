import 'package:flutter/material.dart';
import 'package:jie_app_flutter/api/api.dart';
import 'package:jie_app_flutter/pages/home_page/home_controller.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  final TabController tabbarController;
  const HomePage(this.tabbarController, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            var res = await Api.test();
            print(res);
          },
          child: const Text('首页'),
        ),
      ),
    );
  }
}
