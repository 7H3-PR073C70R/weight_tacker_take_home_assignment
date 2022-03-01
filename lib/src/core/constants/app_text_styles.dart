import 'package:flutter/material.dart';
import 'app_string.dart';

class AppTextStyles {
  static const headerTextStyle = TextStyle(
      fontFamily: AppString.fontFamily,
      fontSize: 20,
      fontWeight: FontWeight.bold);

  static const buttonTextStyle = TextStyle(
      fontFamily: AppString.fontFamily,
      fontSize: 18,
      color: Colors.white,
      fontWeight: FontWeight.w700);
      
  static const bodyTextStyle = TextStyle(
      fontFamily: AppString.fontFamily,
      fontSize: 16,
      fontWeight: FontWeight.w500);
}
