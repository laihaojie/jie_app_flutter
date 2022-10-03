import 'package:flutter/material.dart';
import 'package:jie_app_flutter/routers/app_pages.dart';
import 'package:get/get.dart';

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: AppPages.initial,
    getPages: AppPages.routes,
  ));
}
