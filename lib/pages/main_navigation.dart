import 'package:flutter/material.dart';
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
      bottomNavigationBar: GFTabBar(
        // key: AppPages.globalKey,
        length: 4,
        controller: controller.tabController,
        tabs: const [
          Tab(icon: Icon(Icons.home), child: Text("首页")),
          Tab(icon: Icon(Icons.task), child: Text("任务")),
          Tab(icon: Icon(Icons.note), child: Text("笔记")),
          Tab(icon: Icon(Icons.book), child: Text("我的")),
        ],
      ),
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
