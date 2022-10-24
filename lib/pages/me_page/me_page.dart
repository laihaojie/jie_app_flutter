import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jie_preview_image/jie_preview_image.dart';

import '../../routers/app_pages.dart';
import '../../utils/gaps.dart';
import 'me_controller.dart';

class MePage extends GetView<MeController> {
  const MePage(this.tabbarController, {super.key});
  final TabController tabbarController;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller,
      builder: (controller) {
        return Column(
          children: [
            Gaps.vGap50,
            ClipOval(
              child: GestureDetector(
                onTap: () {
                  previewImage(context, urls: [controller.userInfo.avatar]);
                },
                child: Hero(
                  tag: controller.userInfo.avatar,
                  child: Image.network(
                    controller.userInfo.avatar,
                    width: 100,
                    height: 100,
                  ),
                ),
              ),
            ),
            Gaps.vGap50,
            ListTile(
              onTap: () => Get.toNamed(AppRouters.setting),
              leading: const Icon(Icons.settings),
              horizontalTitleGap: 0,
              title: const Text('设置'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            ),
          ],
        );
      },
    );
  }
}
