// ignore_for_file: avoid_print

import 'package:get/get.dart';

class HomeController extends GetxController with GetSingleTickerProviderStateMixin {
  var counter = 0.obs;

  var websiteList = [
    {'name': '百度', 'url': 'https://www.baidu.com'},
    // {'name': '打开网站', 'url': 'http://www.laihaojie.com'},
    // {'name': '木鱼', 'url': 'https://muyu.laihaojie.com'},
    // {'name': '冰墩墩', 'url': 'http://bdd.laihaojie.com'},
    // {'name': '后台', 'url': 'https://admin.laihaojie.com'},
  ];

  @override
  void onInit() {
    super.onInit();
    print('home controller 初始化了');
  }

  void increment() {
    counter++;
  }
}
