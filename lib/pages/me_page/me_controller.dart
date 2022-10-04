import 'package:get/get.dart';
import 'package:jie_app_flutter/api/api.dart';
import 'package:jie_app_flutter/models/user_model.dart';
import 'package:jie_app_flutter/utils/sp_util.dart';

class MeController extends GetxController {
  UserModel userInfo = UserModel.fromJson(SpUtil().localGet('user_info'));

  loadData() async {
    UserModel res = await Api.getUserInfo();
    userInfo = res;
    update();
  }

  @override
  void onReady() {
    super.onReady();
    loadData();
  }
}
