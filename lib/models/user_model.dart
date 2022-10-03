class UserModel {
  UserModel({
    required this.id,
    required this.account,
    required this.avatar,
    required this.nickName,
    required this.createTime,
    required this.role,
  });
  late final String id;
  late final String account;
  late final String avatar;
  late final String nickName;
  late final String createTime;
  late final int role;

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    account = json['account'];
    avatar = json['avatar'];
    nickName = json['nick_name'];
    createTime = json['create_time'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['account'] = account;
    data['avatar'] = avatar;
    data['nick_name'] = nickName;
    data['create_time'] = createTime;
    data['role'] = role;
    return data;
  }
}
