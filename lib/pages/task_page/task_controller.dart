import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../api/api.dart';
import '../../models/task_model.dart';
import '../../utils/utils.dart';

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
  var node = FocusNode();
  var editNode = FocusNode();
  var textEditingController = TextEditingController();

  Future<void> getTaskList() async {
    final List<TaskModel> res = await Api.getTaskList({'status': index.value + 1});
    taskList.assignAll(res);
  }

  @override
  void onInit() {
    super.onInit();
    textEditingController.text = isEdit.value ? '' : task;
    index.listen((value) {
      isEdit.value = false;
      getTaskList();
    });
    getTaskList();
  }

  saveTask() async {
    if (task.isEmpty) {
      return Utils.toast('请输入代办事项');
    }
    await Api.saveTask({'task': task});
    getTaskList();
    editNode.unfocus();
  }

  Future<void> updateTaskStatus(TaskModel item, int i) async {
    await Api.updateTask({'id': item.id, 'status': i});
    getTaskList();
    Utils.toast('修改成功');
  }

  Future<void> updateTask(TaskModel item) async {
    final inputTask = task;
    task = '';
    if (inputTask.isEmpty) {
      return Utils.toast('请输入代办事项');
    }
    if (item.task == inputTask) {
      return Utils.toast('未修改');
    }
    await Api.updateTask({
      'id': item.id,
      'status': item.status,
      'task': inputTask,
    });
    isEdit.value = false;
    getTaskList();
    Utils.toast('修改成功');
  }
}
