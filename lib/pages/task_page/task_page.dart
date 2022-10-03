import 'package:flutter/material.dart';
import 'package:jie_app_flutter/common/app_config.dart';
import 'package:jie_app_flutter/models/task_model.dart';
import 'package:jie_app_flutter/pages/task_page/task_controller.dart';
import 'package:jie_app_flutter/utils/gaps.dart';

import 'package:get/get.dart';

class TaskPage extends GetView<TaskController> {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          backgroundColor: AppConfig.mainColor,
          // 去除阴影
          elevation: 0,
          title: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: TextField(
                    cursorHeight: 20,
                    onChanged: (value) {
                      controller.task.value = value;
                    },
                    controller:
                        TextEditingController(text: controller.task.value),
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: '请输入代办事项',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ),
              Gaps.hGap15,
              ElevatedButton(
                onPressed: () {
                  controller.saveTask();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppConfig.whiteColor,
                ),
                child: const Text(
                  '保存',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Gaps.vGap2,
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  children: [
                    for (int i = 0; i < controller.status.length; i++)
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            controller.index.value = i;
                          },
                          style: OutlinedButton.styleFrom(
                            backgroundColor: controller.index.value == i
                                ? AppConfig.mainColor
                                : AppConfig.whiteColor,
                          ),
                          child: Text(
                            controller.status[i],
                            style: TextStyle(
                              color: controller.index.value == i
                                  ? AppConfig.whiteColor
                                  : AppConfig.mainColor,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              for (int index = 0; index < controller.taskList.length; index++)
                GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            controller.taskList[index].task,
                            // 溢出省略号
                            overflow: TextOverflow.fade,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _showActions(context, controller.taskList[index]);
                          },
                          child: Image.asset(
                            'assets/images/dots.png',
                            width: 20,
                            height: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  _showActions(
    BuildContext context,
    TaskModel item,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            controller.index.value != 1
                ? InkWell(
                    onTap: () {
                      controller.updateTask(item, 2);
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey[200]!,
                            width: 0.5,
                          ),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          '完成',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  )
                : const SizedBox(),
            controller.index.value != 0
                ? InkWell(
                    onTap: () {
                      controller.updateTask(item, 1);
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey[200]!,
                            width: 0.5,
                          ),
                        ),
                      ),
                      height: 50,
                      child: const Center(
                        child: Text(
                          '撤回',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  )
                : const SizedBox(),
            controller.index.value != 2
                ? InkWell(
                    onTap: (() {
                      controller.updateTask(item, 3);
                      Navigator.pop(context);
                    }),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey[200]!,
                            width: 0.5,
                          ),
                        ),
                      ),
                      height: 50,
                      child: const Center(
                        child: Text(
                          '待处理',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  )
                : const SizedBox(),
            controller.index.value != 3
                ? InkWell(
                    onTap: () {
                      controller.updateTask(item, 0);
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey[200]!,
                            width: 0.5,
                          ),
                        ),
                      ),
                      height: 50,
                      child: const Center(
                        child: Text(
                          '删除',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  )
                : const SizedBox(),
            Container(
              height: 4,
              color: Colors.grey[200],
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const SizedBox(
                height: 50,
                child: Center(
                  child: Text(
                    '取消',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
