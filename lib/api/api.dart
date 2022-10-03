import 'package:jie_app_flutter/models/task_model.dart';
import 'package:jie_app_flutter/utils/request.dart';

class Api {
  static Future<String> test() async {
    return await get('/api/test');
  }

  static Future<List<TaskModel>> getTaskList(data) async {
    return (await get('/api/todoList/taskList', params: data) as List)
        .map((e) => TaskModel.fromJson(e))
        .toList();
  }

  static Future saveTask(Map<String, dynamic> map) async {
    return post('/api/todoList/createTask', data: map);
  }

  static Future updateTask(Map<String, dynamic> map) async {
    return post('/api/todoList/updateTask', data: map);
  }
}
