import 'package:get/get.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  var counter = 0.obs;

  @override
  void onInit() {
    super.onInit();
    print('home controller 初始化了');
  }

  void increment() {
    counter++;
  }
}
