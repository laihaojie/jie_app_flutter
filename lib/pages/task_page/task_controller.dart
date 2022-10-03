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

  var task = ''.obs;

  Future<void> getTaskList() async {
    List<TaskModel> res = await Api.getTaskList({'status': index.value + 1});
    taskList.assignAll(res);
  }

  @override
  void onInit() {
    super.onInit();
    index.listen((value) {
      getTaskList();
    });
    getTaskList();
  }

  saveTask() async {
    if (task.value.isEmpty) {
      return Utils.toast("请输入代办事项");
    }
    await Api.saveTask({'task': task.value});
    getTaskList();
  }

  void updateTask(TaskModel item, int i) async {
    await Api.updateTask({'id': item.id, 'status': i});
    getTaskList();
    Utils.toast("修改成功");
  }
}
