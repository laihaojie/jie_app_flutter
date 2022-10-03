import 'package:flutter/material.dart';
import 'package:jie_app_flutter/routers/app_pages.dart';
import 'package:get/get.dart';

class Test1Page extends StatelessWidget {
  const Test1Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Test1Page')),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () => Get.toNamed(AppRouters.test2),
                child: const Text('回到上一页'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
