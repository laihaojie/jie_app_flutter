// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_page/home_controller.dart';
import 'me_page/me_controller.dart';
import 'note_page/note_controller.dart';
import 'task_page/task_controller.dart';

class MainNavigationController extends GetxController
    with GetSingleTickerProviderStateMixin {
  var count = 10.obs;
  var currentIndex = 0.obs;

  late var tabController = TabController(length: 4, vsync: this);
  late var arg = Get.arguments;
  late final List<String> tabs = [
    '首页',
    '任务',
    '笔记',
    '我的',
  ];
  late var title = tabs[tabController.index].obs;

  @override
  void onInit() {
    super.onInit();
    // tabController = TabController(length: 3, vsync: this);
    if (arg != null) {
      final index = arg['index'];
      tabController.animateTo(index);
    }

    tabController.addListener(onChange);

    print('main navigation init');
  }

  onChange() {
    currentIndex.value = tabController.index;
    title.value = tabs[tabController.index];
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  increment(int? val) {
    count++;
    count += val ?? 1;
  }
}

class MainNavigationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainNavigationController>(() => MainNavigationController());
    // Get.lazyPut<HomeController>(() => HomeController());
    Get.put(HomeController());
    Get.lazyPut<TaskController>(() => TaskController());
    Get.lazyPut<NoteController>(() => NoteController());
    Get.lazyPut<MeController>(() => MeController());
  }
}
