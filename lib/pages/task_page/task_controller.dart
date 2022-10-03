import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jie_app_flutter/api/api.dart';
import 'package:jie_app_flutter/models/task_model.dart';
import 'package:jie_app_flutter/utils/utils.dart';

class TaskController extends GetxController {
  var taskList = <TaskModel>[].obs;

  var index = 0.obs;
  var status = [
    '全部',
    '已完成',
    '待处理',
    '已删除',
  ];

  var task = '';

  var isEdit = false.obs;
  late var currentTask = taskList.first.obs;
  var note = FocusNode();

  Future<void> getTaskList() async {
    List<TaskModel> res = await Api.getTaskList({'status': index.value + 1});
    taskList.assignAll(res);
  }

  @override
  void onInit() {
    super.onInit();
    index.listen((value) {
      isEdit.value = false;
      getTaskList();
    });
    getTaskList();
  }

  saveTask() async {
    if (task.isEmpty) {
      return Utils.toast("请输入代办事项");
    }
    await Api.saveTask({'task': task});
    getTaskList();
  }

  void updateTaskStatus(TaskModel item, int i) async {
    await Api.updateTask({'id': item.id, 'status': i});
    getTaskList();
    Utils.toast("修改成功");
  }

  void updateTask(TaskModel item) async {
    var i = task;
    task = '';
    if (i.isEmpty) {
      return Utils.toast("请输入代办事项");
    }
    if (item.task == i) {
      return Utils.toast("未修改");
    }
    await Api.updateTask({
      'id': item.id,
      'status': item.status,
      'task': i,
    });
    isEdit.value = false;
    getTaskList();
    Utils.toast("修改成功");
  }
}
