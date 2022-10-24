// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../api/api.dart';
import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage(this.tabbarController, {super.key});
  final TabController tabbarController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final res = await Api.test();
            print(res);
          },
          child: const Text('首页'),
        ),
      ),
    );
  }
}
