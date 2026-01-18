import 'package:flutter/material.dart';


class ProfileConstData{
  static final List<String> languages=["language_ar","language_en"];

  static final List<String> themes=["theme_light","theme_dark"];

  static String getCurrentTheme(context) {
    return (Theme.of(context).brightness == Brightness.light) ? themes[0] : themes[1];
  }
}