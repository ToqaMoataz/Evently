import 'package:flutter/material.dart';

abstract class MainColors {

  Color getBackgroundColor();

  Color getAppBarColor();

  static Color getMainColor() {
    return const Color(0XFF5669FF);
  }

  static Color getSecondaryColor() {
    return const Color(0XFF1C1C1C);
  }
}
