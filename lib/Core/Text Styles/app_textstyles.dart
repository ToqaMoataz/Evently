import 'package:flutter/material.dart'; // بدل dart:ui
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:evently/Core/Color/main_colors.dart';

import '../../Provider/themeProvider.dart';

class AppTextStyles {
  static TextStyle introTitleStyle() {
    return GoogleFonts.inter(
      color: MainColors.getMainColor(),
      fontSize: 20.sp,
      fontWeight: FontWeight.w700,
      letterSpacing: 0,
      height: 1,
    );
  }

  static TextStyle introBodyStyle(ThemeProvider themeProvider) {
    return GoogleFonts.inter(
      color: (themeProvider.themeMode == ThemeMode.light)
          ? MainColors.getSecondaryColor()
          : Colors.white,
      fontSize: 16.sp,
      fontWeight: FontWeight.w500,
      letterSpacing: 0,
      height: 1,
    );
  }

  static TextStyle titleLargeStyle() {
    return GoogleFonts.inter(
      color: MainColors.getMainColor(),
      fontSize: 20.sp,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      height: 1,
    );
  }

  static TextStyle textFieldStyle(ThemeProvider themeProvider,{Color? color}) {
    return GoogleFonts.inter(
      fontWeight: FontWeight.w500,
      fontSize: 16.sp,
      color: (color != null) ? color
          : (themeProvider.themeMode == ThemeMode.light)
          ? Color(0XFF7B7B7B)
          : Colors.white,

    );
  }

}
