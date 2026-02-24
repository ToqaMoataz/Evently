import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../App Colors/main_colors.dart';

class AppTextStyles {
  // Label Small
  static TextStyle labelSmall({Color? color}) {
    return GoogleFonts.inter(
      fontSize: 10,
      fontWeight: FontWeight.w500,
      color: color,
    );
  }

  // Done
  static TextStyle labelLarge({Color? color}) {
    return GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      color: color,
    );
  }

  // Done
  static TextStyle bodySmall({Color? color}) {
    return GoogleFonts.inter(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: color,
    );
  }

  // Body Medium
  static TextStyle bodyMedium({Color? color}) {
    return GoogleFonts.inter(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: color,
    );
  }

  // Body Large
  static TextStyle bodyLarge({required ThemeMode themeMode}) {
    return GoogleFonts.inter(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: themeMode == ThemeMode.light
          ? MainColors.getDarkColor()
          : MainColors.getLightColor()
    );
  }

  // Done
  static TextStyle titleSmall({required FontWeight weight}) {
    return GoogleFonts.inter(
      fontSize: 14,
      fontWeight: weight,
      color: MainColors.getLightColor(),
    );
  }

  // Done
  static TextStyle titleMedium({Color? color}) {
    return GoogleFonts.inter(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: color ?? MainColors.getLightColor(),
    );
  }

  // Done
  static TextStyle titleLarge() {
    return GoogleFonts.inter(
      fontSize: 20.sp,
      fontWeight: FontWeight.w700,
      color: MainColors.getLightColor(),
    );
  }
   //Done
  static TextStyle appbarTitle() {
    return GoogleFonts.inter(
      fontSize: 22,
      fontWeight: FontWeight.w400,
      color: MainColors.getMainColor(),
    );
  }

  static TextStyle buttonTextStyle({Color? color}) {
    return GoogleFonts.inter(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: (color!=null) ? color : MainColors.getLightColor(),
    );
  }

  static TextStyle hintTextStyle({Color? color}) {
    return GoogleFonts.inter(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: color
    );
  }


  static TextStyle userNameTextStyle() {
    return GoogleFonts.inter(
      fontSize: 24.sp,
      fontWeight: FontWeight.w700,
      color: MainColors.getLightColor(),
    );
  }

  static TextStyle categoryCardTextStyle({required Color color}) {
    return GoogleFonts.inter(
      fontSize: 16.sp,
      fontWeight: FontWeight.w500,
      color: color,
    );
  }

  static TextStyle errorTextStyle() {
    return GoogleFonts.inter(
      fontSize: 24.sp,
      fontWeight: FontWeight.w600,
      color: MainColors.getMainColor(),
      letterSpacing: 0,
      height: 1
    );
  }


}
