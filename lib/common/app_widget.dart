import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppWidget {
  static Container gap({double height = 10}) {
    return Container(
      height: height,
      decoration: const BoxDecoration(
        color: Color(0xffF5F5F5),
      ),
    );
  }

  static Text textSizeColor(
    String content,
    double size,
    Color? color,
  ) {
    return color == null
        ? Text(content, style: TextStyle(fontSize: size))
        : Text(content, style: TextStyle(fontSize: size, color: color));
  }
}
