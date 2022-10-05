import 'package:flutter/material.dart';
import 'package:jie_app_flutter/api/api.dart';
import 'package:jie_app_flutter/routers/app_pages.dart';
import 'package:get/get.dart';
import 'package:jie_app_flutter/utils/sp_util.dart';
import 'package:ota_update/ota_update.dart';

void main() async {
  // 确定初始化完成
  WidgetsFlutterBinding.ensureInitialized();

  await SpUtil().init();

  // ignore: prefer-async-await
  checkVersion().then((data) {
    if (data.isNotEmpty) {
      showDialog(
        context: Get.context!,
        builder: (context) {
          return AlertDialog(
            title: const Text('发现新版本'),
            content: const Text('是否更新'),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text('取消'),
              ),
              TextButton(
                onPressed: () {
                  Get.back();
                  try {
                    OtaUpdate().execute(data['apkUrl']!).listen(
                      (OtaEvent event) {
                        print(event.value);
                      },
                    ).onDone(() {
                      SpUtil().localSet('dev_version', data['devVersion']);
                    });
                  } catch (e) {
                    print('Failed to make OTA update. Details: $e');
                  }
                },
                child: const Text('确定'),
              ),
            ],
          );
        },
      );
    }
  });

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute:
        SpUtil().localGet('token') == null ? AppRouters.login : AppRouters.main,
    getPages: AppPages.routes,
  ));
}

Future<Map<String, dynamic>> checkVersion() async {
  var res = await Api.checkVersion();

  String version = res['devVersion'];
  String devVersion = SpUtil().localGet('dev_version') ?? '';
  if (version == devVersion) {
    return {};
  }

  return res;
}
