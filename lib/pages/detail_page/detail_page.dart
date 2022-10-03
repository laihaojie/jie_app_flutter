import 'package:flutter/material.dart';
import 'package:jie_app_flutter/pages/detail_page/detail_controller.dart';
import 'package:jie_app_flutter/pages/home_page/home_controller.dart';
import 'package:get/get.dart';

class DetailPage extends GetView<DetailController> {
  DetailPage({super.key});

  final HomeController _homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    print(_homeController.counter);

    return Scaffold(
      appBar: AppBar(title: const Text('DetailPage')),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Text('DetailController: ${controller.name}'),
              ElevatedButton(
                onPressed: () => controller.back(),
                child: const Text('回到上一页'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
