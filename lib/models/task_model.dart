class TaskModel {
  TaskModel({
    required this.id,
    required this.task,
    required this.status,
    required this.createTime,
  });
  late final String id;
  late final String task;
  late final int status;
  late final String createTime;

  TaskModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    task = json['task'];
    status = json['status'];
    createTime = json['create_time'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['task'] = task;
    data['status'] = status;
    data['create_time'] = createTime;
    return data;
  }
}
