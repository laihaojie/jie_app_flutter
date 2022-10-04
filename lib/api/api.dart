import 'package:jie_app_flutter/models/note_model.dart';
import 'package:jie_app_flutter/models/task_model.dart';
import 'package:jie_app_flutter/models/user_model.dart';
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

  static Future<List<NoteModel>> getNoteList() async {
    return (await get('/api/todoList/textList') as List)
        .map((e) => NoteModel.fromJson(e))
        .toList();
  }

  static Future saveTask(Map<String, dynamic> map) async {
    return post('/api/todoList/createTask', data: map);
  }

  static Future updateTask(Map<String, dynamic> map) async {
    return post('/api/todoList/updateTask', data: map);
  }

  static Future login(Map<String, Object> data) async {
    return await post('/api/account/login', data: data);
  }

  static Future<UserModel> getUserInfo() async {
    return UserModel.fromJson(await get('/api/account/info'));
  }

  static Future removeNote(data) async {
    return await post('/api/todoList/removeText', data: data);
  }

  static Future saveNote(Map<String, dynamic> map) async {
    return post('/api/todoList/createText', data: map);
  }

  static Future updateNote(Map<String, dynamic> map) async {
    return post('/api/todoList/updateText', data: map);
  }
}
