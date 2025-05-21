import 'package:flutter/material.dart';

class AppColors {
  // 空气质量指数颜色
  static Color getAqiColor(double value) {
    if (value <= 15.4) return Colors.green;
    if (value <= 35.4) return Colors.yellow;
    if (value <= 54.4) return Colors.orange;
    if (value <= 150.4) return Colors.red;
    return Colors.purple;
  }

  // 主题色
  static const Color primaryColor = Colors.purple;
  static const Color secondaryColor = Colors.blue;

  // 文本颜色
  static const Color textPrimary = Colors.black87;
  static const Color textSecondary = Colors.black54;

  // 背景颜色
  static const Color background = Colors.white;
  static const Color surface = Colors.white;

  // 状态颜色
  static const Color success = Colors.green;
  static const Color warning = Colors.orange;
  static const Color error = Colors.red;
  static const Color info = Colors.blue;
}
