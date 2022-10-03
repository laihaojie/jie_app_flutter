import 'package:flutter/material.dart';
import 'package:jie_app_flutter/pages/home_page/home_controller.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  final TabController tabbarController;
  const HomePage(this.tabbarController, {super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const FlutterLogo(size: 100),
          const FlutterLogo(size: 100),
          const FlutterLogo(size: 100),
          // ignore: avoid-shrink-wrap-in-lists
          ListView.builder(
            shrinkWrap: true,
            itemCount: 10,
            itemBuilder: ((context, index) {
              return Text("index: $index ${controller.counter}");
            }),
          ),
        ],
      ),
    );
  }
}
