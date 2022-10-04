import 'package:flutter/material.dart';
import 'package:jie_app_flutter/common/app_config.dart';
import 'package:jie_app_flutter/pages/home_page/home_page.dart';
import 'package:jie_app_flutter/pages/main_navigation_controller.dart';
import 'package:jie_app_flutter/pages/me_page/me_page.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:jie_app_flutter/pages/note_page/note_page.dart';
import 'package:jie_app_flutter/pages/task_page/task_page.dart';

class MainNavigation extends GetView<MainNavigationController> {
  const MainNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(() => GFTabBar(
            length: 4,
            tabBarColor: Colors.white,
            indicatorColor: Colors.transparent,
            controller: controller.tabController,
            tabs: [
              Tab(
                icon: Icon(
                  Icons.home,
                  size: 30,
                  color: controller.currentIndex.value == 0
                      ? AppConfig.mainColor
                      : AppConfig.color333,
                ),
                iconMargin: const EdgeInsets.only(bottom: 4),
                child: Text(
                  "首页",
                  style: TextStyle(
                    color: controller.currentIndex.value == 0
                        ? AppConfig.mainColor
                        : AppConfig.color333,
                  ),
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.bar_chart_sharp,
                  size: 30,
                  color: controller.currentIndex.value == 1
                      ? AppConfig.mainColor
                      : AppConfig.color333,
                ),
                iconMargin: const EdgeInsets.only(bottom: 4),
                child: Text(
                  "任务",
                  style: TextStyle(
                    color: controller.currentIndex.value == 1
                        ? AppConfig.mainColor
                        : AppConfig.color333,
                  ),
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.note,
                  size: 30,
                  color: controller.currentIndex.value == 2
                      ? AppConfig.mainColor
                      : AppConfig.color333,
                ),
                iconMargin: const EdgeInsets.only(bottom: 4),
                child: Text(
                  "笔记",
                  style: TextStyle(
                    color: controller.currentIndex.value == 2
                        ? AppConfig.mainColor
                        : AppConfig.color333,
                  ),
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.book,
                  size: 30,
                  color: controller.currentIndex.value == 3
                      ? AppConfig.mainColor
                      : AppConfig.color333,
                ),
                iconMargin: const EdgeInsets.only(bottom: 4),
                child: Text(
                  "我的",
                  style: TextStyle(
                    color: controller.currentIndex.value == 3
                        ? AppConfig.mainColor
                        : AppConfig.color333,
                  ),
                ),
              ),
            ],
          )),
      body: GFTabBarView(
        // 禁用左右滚动切换
        physics: const NeverScrollableScrollPhysics(),
        // physics: const BouncingScrollPhysics(),
        controller: controller.tabController,
        children: <Widget>[
          HomePage(controller.tabController),
          const TaskPage(),
          const NotePage(),
          MePage(controller.tabController),
        ],
      ),
    );
  }
}
