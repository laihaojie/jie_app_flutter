import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'routers/app_pages.dart';
import 'utils/check_update.dart';
import 'utils/sp_util.dart';

void main() async {
  // 确定初始化完成
  WidgetsFlutterBinding.ensureInitialized();

  await SpUtil().init();

  // 检查apk版本更新
  checkUpdate();

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: SpUtil().localGet('token') == null ? AppRouters.login : AppRouters.main,
    getPages: AppPages.routes,
  ));
}
