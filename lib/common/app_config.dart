import 'dart:ui';

import 'package:jie_app_flutter/utils/utils.dart';

class AppConfig {
  static const String baseUrl = "https://api.laihaojie.com";

  static const int connectTimeout = 15000;

  static const int receiveTimeout = 15000;

  static Color get mainColor => Utils.color("#027AFF");
  static Color get mainRedColor => Utils.color("#DE3030");
  static Color get whiteColor => Utils.color("#FFFFFF");
  static Color get blackColor => Utils.color("#000000");
  static Color get color333 => Utils.color("#333333");
}
