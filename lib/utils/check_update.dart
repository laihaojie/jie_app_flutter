import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jie_app_flutter/api/api.dart';
import 'package:jie_app_flutter/utils/sp_util.dart';
import 'package:ota_update/ota_update.dart';

void checkUpdate() async {
  var data = await checkVersion();
  if (data.isNotEmpty) {
    showDialog(
      context: Get.context!,
      builder: (context) {
        return AlertDialog(
          title: const Text('发现新版本'),
          content: const Text('是否更新'),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text('取消'),
            ),
            TextButton(
              onPressed: () {
                Get.back();
                downloadApk(data);
              },
              child: const Text('确定'),
            ),
          ],
        );
      },
    );
  }
}

void downloadApk(data) async {
  showDialog(
    context: Get.context!,
    builder: (context) {
      return AlertDialog(
        title: const Text('下载中'),
        content: DownLoadProgress(data),
      );
    },
  );
}

Future<Map<String, dynamic>> checkVersion() async {
  var res = await Api.checkVersion();

  String version = res['devVersion'];
  String devVersion = SpUtil().localGet('dev_version') ?? '';
  if (version == devVersion) return {};
  // 第一次安装 保存版本号
  if (devVersion.isEmpty) {
    SpUtil().localSet('dev_version', version);

    return {};
  }

  return res;
}

// ignore: prefer-match-file-name
class DownLoadProgress extends StatefulWidget {
  final Map<String, dynamic> data;
  const DownLoadProgress(this.data, {super.key});

  @override
  State<DownLoadProgress> createState() => _DownLoadProgressState();
}

class _DownLoadProgressState extends State<DownLoadProgress> {
  var progress = 0.0;

  @override
  void initState() {
    super.initState();
    try {
      OtaUpdate().execute(widget.data['apkUrl']!).listen(
        (OtaEvent event) {
          setState(() {
            if (event.value != null && event.value!.isNotEmpty) {
              progress = double.parse(event.value ?? '0.0') / 100;
            }
          });
        },
      ).onDone(() {
        Navigator.of(context).pop();
        SpUtil().localSet('dev_version', widget.data['devVersion']);
      });
    } catch (e) {
      print('OTA 下载失败 Details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: LinearProgressIndicator(value: progress)),
        const SizedBox(width: 10),
        Text('${(progress * 100).toStringAsFixed(0)}%'),
      ],
    );
  }
}
