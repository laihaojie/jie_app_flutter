import 'dart:async';

import 'package:get/get.dart';

class MeController extends GetxController {
  var count = 0.obs;

  late final timer;

  @override
  onInit() {
    super.onInit();
    print('MeController onInit');
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      count.value++;
    });
  }

  @override
  onClose() {
    super.onClose();
    print('MeController onClose');
    timer.cancel();
  }

  add() {
    count++;
  }
}
