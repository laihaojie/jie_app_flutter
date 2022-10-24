import 'package:get/get.dart';
import '../../api/api.dart';
import '../../models/user_model.dart';
import '../../utils/sp_util.dart';

class MeController extends GetxController {
  UserModel userInfo = UserModel.fromJson(SpUtil().localGet('user_info'));

  loadData() async {
    final UserModel res = await Api.getUserInfo();
    userInfo = res;
    update();
  }

  @override
  void onReady() {
    super.onReady();
    loadData();
  }
}
