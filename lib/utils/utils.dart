import 'dart:ui';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:jie_app_flutter/utils/sp_util.dart';

class Utils {
  static Color color([String code = "#999999"]) {
    if (code.isEmpty ||
        code[0] != "#" ||
        (code.length != 4 && code.length != 7)) {
      throw "传的字符串格式错误";
    }
    if (code.length == 4) {
      code = "#${code[1]}${code[1]}${code[2]}${code[2]}${code[3]}${code[3]}";
    }

    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  static void toast(String? msg) {
    if (msg == null) {
      return;
    }
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Utils.color("#000"),
      textColor: Utils.color("#FFF"),
      fontSize: 16.0,
    );
  }

  // ignore: long-method
  static bool testid(String cardId) {
    if (cardId.length != 18) {
      return false; // 位数不够
    }
    // 身份证号码正则
    RegExp postalCode = RegExp(
      r'^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}([0-9]|[Xx])$',
    );
    // 通过验证，说明格式正确，但仍需计算准确性
    if (!postalCode.hasMatch(cardId)) {
      return false;
    }
    //将前17位加权因子保存在数组里
    final List idCardList = [
      "7",
      "9",
      "10",
      "5",
      "8",
      "4",
      "2",
      "1",
      "6",
      "3",
      "7",
      "9",
      "10",
      "5",
      "8",
      "4",
      "2",
    ];
    //这是除以11后，可能产生的11位余数、验证码，也保存成数组
    final List idCardYArray = [
      '1',
      '0',
      '10',
      '9',
      '8',
      '7',
      '6',
      '5',
      '4',
      '3',
      '2',
    ];
    // 前17位各自乖以加权因子后的总和
    int idCardWiSum = 0;

    for (int item = 0; item < 17; item++) {
      int subStrIndex = int.parse(cardId.substring(item, item + 1));
      int idCardWiIndex = int.parse(idCardList[item]);
      idCardWiSum += subStrIndex * idCardWiIndex;
    }
    // 计算出校验码所在数组的位置
    int idCardMod = idCardWiSum % 11;
    // 得到最后一位号码
    String idCardLast = cardId.substring(17, 18);
    //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
    if (idCardMod == 2) {
      if (idCardLast != 'x' && idCardLast != 'X') {
        return false;
      }
    } else {
      //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
      if (idCardLast != idCardYArray[idCardMod]) {
        return false;
      }
    }

    return true;
  }

  static bool testMobile(String mobile) =>
      RegExp(r'^1[0123456789]\d{9}$').hasMatch(mobile);

  static bool testEmail(String email) =>
      RegExp(r'^([a-zA-Z]|[0-9])(\w|\-)+@[a-zA-Z0-9]+\.([a-zA-Z]{2,4})$')
          .hasMatch(email);

  static bool get isLogin => SpUtil().localGet("token") != null;

  static Future<bool> checkLogin() async {
    return SpUtil().localGet("token") != null;
  }
}
