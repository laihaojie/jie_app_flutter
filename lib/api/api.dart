import 'package:jie_app_flutter/utils/request.dart';

class Api {
  static Future<String> test() async {
    return await get('/api/test');
  }
}
