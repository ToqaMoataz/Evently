import 'package:flutter/material.dart';

abstract class MainColors {

  Color getBackgroundColor();

  Color getAppBarColor();

  static Color getMainColor() {
    return const Color(0XFF5669FF);
  }

  static Color getDarkColor() {
    return const Color(0XFF101127);
  }

  static Color getLightColor() {
    return const Color(0XFFF2FEFF);
  }

  static Color getRedColor() {
    return const Color(0XFFFF5659);
  }

  static Color getGreyColor() {
    return const Color(0XFF7B7B7B);
  }
}
