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
    return Scaffold(
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
                    print('111111111111111111111');
                    controller.task = controller.isEdit.value ? '' : value;
                  },
                  controller: TextEditingController(
                    text: controller.isEdit.value ? '' : controller.task,
                  ),
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
      body: Obx(
        () => GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
            controller.isEdit.value = false;
          },
          child: SingleChildScrollView(
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
                    onLongPress: () {
                      controller.currentTask.value = controller.taskList[index];
                      controller.isEdit.value = true;
                      // 一秒后自动获取焦点弹出键盘
                      Future.delayed(const Duration(milliseconds: 100), () {
                        FocusScope.of(context).requestFocus(controller.note);
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          controller.isEdit.value &&
                                  controller.currentTask.value.id ==
                                      controller.taskList[index].id
                              ? Expanded(
                                  child: Focus(
                                    onFocusChange: (value) {
                                      if (!value) {
                                        // controller.isEdit.value = false;
                                        controller.updateTask(
                                          controller.currentTask.value,
                                        );
                                      } else {
                                        controller.task =
                                            controller.currentTask.value.task;
                                      }
                                    },
                                    // autofocus: true,
                                    child: TextField(
                                      controller: TextEditingController(
                                        text: controller.currentTask.value.task,
                                      ),
                                      onChanged: (value) {
                                        controller.task = value;
                                      },
                                      focusNode: controller.note,
                                      autofocus: true,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.all(10),
                                        border: const OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                        ),
                                        filled: true,
                                        fillColor: Colors.grey[50],
                                        hintText: '请输入代办事项',
                                        hintStyle:
                                            const TextStyle(color: Colors.grey),
                                      ),
                                    ),
                                  ),
                                )
                              : Expanded(
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
                      controller.updateTaskStatus(item, 2);
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
                      controller.updateTaskStatus(item, 1);
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
                      controller.updateTaskStatus(item, 3);
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
                      // show delete dialog
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('提示'),
                            content: const Text('确定删除吗？'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('取消'),
                              ),
                              TextButton(
                                onPressed: () {
                                  controller.updateTaskStatus(item, 0);
                                  Navigator.pop(context);
                                },
                                child: const Text('确定'),
                              ),
                            ],
                          );
                        },
                      );
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
