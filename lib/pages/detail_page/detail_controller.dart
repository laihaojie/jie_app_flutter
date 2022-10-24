// ignore_for_file: avoid_print

import 'package:get/get.dart';

import '../../routers/app_pages.dart';

class DetailController extends GetxController {
  var name = 'DetailController'.obs;

  back() {
    // Get.until((route) => false);
    // Get.offAllNamed(AppRouters.main, arguments: {'index': 1, 'age': 'test'});
    // Get.until((route) => Get.currentRoute == AppRouters.main);
    // Get.toNamed(AppRouters.main);
    Get.toNamed(AppRouters.test1);
  }

  @override
  void onInit() {
    super.onInit();
    print('detail controller 初始化了');
  }
}

class DetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailController>(() => DetailController());
  }
}
