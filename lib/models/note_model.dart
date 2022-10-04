class NoteModel {
  NoteModel({
    required this.id,
    required this.text,
    required this.isDelete,
    required this.createTime,
  });
  late final String id;
  late final String text;
  late final int isDelete;
  late final String createTime;

  NoteModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    isDelete = json['is_delete'];
    createTime = json['create_time'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['text'] = text;
    data['is_delete'] = isDelete;
    data['create_time'] = createTime;
    return data;
  }
}
