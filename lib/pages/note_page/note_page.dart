import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jie_app_flutter/common/app_config.dart';
import 'package:jie_app_flutter/models/note_model.dart';
import 'package:jie_app_flutter/pages/note_page/note_controller.dart';
import 'package:jie_app_flutter/utils/gaps.dart';

class NotePage extends GetView<NoteController> {
  const NotePage({super.key});

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
                  focusNode: controller.editNote,
                  onChanged: (value) =>
                      controller.note = controller.isEdit.value ? '' : value,
                  controller: controller.textEditingController,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: '请输入笔记',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            ),
            Gaps.hGap15,
            ElevatedButton(
              onPressed: () => controller.saveNote(),
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
            FocusScope.of(context).requestFocus(controller.editNote);
            controller.isEdit.value = false;
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (int index = 0; index < controller.noteList.length; index++)
                  GestureDetector(
                    onLongPress: () {
                      controller.currentNote.value = controller.noteList[index];
                      controller.isEdit.value = true;
                      // 一秒后自动获取焦点弹出键盘
                      Future.delayed(const Duration(milliseconds: 100), () {
                        FocusScope.of(context).requestFocus(controller.node);
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          controller.isEdit.value &&
                                  controller.currentNote.value.id ==
                                      controller.noteList[index].id
                              ? Expanded(
                                  child: Focus(
                                    onFocusChange: (value) {
                                      if (!value) {
                                        controller.isEdit.value = false;
                                        controller.updateNote(
                                          controller.currentNote.value,
                                        );
                                      } else {
                                        controller.note =
                                            controller.currentNote.value.text;
                                      }
                                    },
                                    // autofocus: true,
                                    child: TextField(
                                      controller: TextEditingController(
                                        text: controller.currentNote.value.text,
                                      ),
                                      onChanged: (value) =>
                                          controller.note = value,
                                      focusNode: controller.node,
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
                                    controller.noteList[index].text,
                                    // 溢出省略号
                                    overflow: TextOverflow.fade,
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                          GestureDetector(
                            onTap: () => _showActions(
                              context,
                              controller.noteList[index],
                            ),
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
    NoteModel item,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
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
                            controller.removeNote(item);
                            Navigator.pop(context);
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
            ),
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
