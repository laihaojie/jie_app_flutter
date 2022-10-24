import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../api/api.dart';
import '../../models/note_model.dart';
import '../../utils/utils.dart';

class NoteController extends GetxController {
  var noteList = <NoteModel>[].obs;

  var index = 0.obs;

  var note = '';

  var isEdit = false.obs;
  late var currentNote = noteList.first.obs;
  var node = FocusNode();
  var editNote = FocusNode();
  var textEditingController = TextEditingController();

  Future<void> getNoteList() async {
    final List<NoteModel> res = await Api.getNoteList();
    noteList.assignAll(res);
  }

  @override
  void onInit() {
    super.onInit();
    textEditingController.text = isEdit.value ? '' : note;
    index.listen((value) {
      isEdit.value = false;
      getNoteList();
    });
    getNoteList();
  }

  saveNote() async {
    if (note.isEmpty) {
      return Utils.toast('请输入代办事项');
    }
    await Api.saveNote({'text': note});
    textEditingController.text = '';
    editNote.unfocus();
    getNoteList();
  }

  Future<void> removeNote(NoteModel item) async {
    await Api.removeNote({'id': item.id});
    getNoteList();
    Utils.toast('删除成功');
  }

  Future<void> updateNote(NoteModel item) async {
    final inputNote = note;
    note = '';
    if (inputNote.isEmpty) {
      return Utils.toast('请输入代办事项');
    }
    if (item.text == inputNote) {
      return Utils.toast('未修改');
    }
    await Api.updateNote({
      'id': item.id,
      'text': inputNote,
    });
    isEdit.value = false;
    getNoteList();
    Utils.toast('修改成功');
  }
}
