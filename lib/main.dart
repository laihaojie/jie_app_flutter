import 'package:flutter/material.dart';
import 'package:jie_app_flutter/routers/app_pages.dart';
import 'package:get/get.dart';
import 'package:jie_app_flutter/utils/sp_util.dart';

void main() async {
  // 确定初始化完成
  WidgetsFlutterBinding.ensureInitialized();

  await SpUtil().init();
  SpUtil().localSet(
    'token',
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjEiLCJyb2xlIjoxLCJpYXQiOjE2NjMwMzc4NDIsImV4cCI6MTY2NTYyOTg0Mn0.0TaepUA78lTQygH3So6bDFOgV99dC9CTWWrrUJgRX4U",
  );

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: AppPages.initial,
    getPages: AppPages.routes,
  ));
}
