import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:evently/Core/Color/main_colors.dart';
import '../Provider/themeProvider.dart';

class AppTextStyles {
  //var themeProvider=Provider.of<ThemeProvider>(context);

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
          ? MainColors.getTextSecondaryColor()
          : Colors.white,
      fontSize: 16.sp,
      fontWeight: FontWeight.w500,
      letterSpacing: 0,
      height: 1,
    );
  }

  static TextStyle simpleTitleStyle() {
    return GoogleFonts.inter(
      color: MainColors.getMainColor(),
      fontSize: 20.sp,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      height: 1,
    );
  }

  static TextStyle largeTitleStyle() {
    return GoogleFonts.inter(
      color: MainColors.getTextPrimaryColor(),
      fontSize: 24.sp,
      fontWeight: FontWeight.w700,
      height: 1,
      letterSpacing: 0,
    );
  }
  static TextStyle mediumTitleStyle() {
    return GoogleFonts.inter(
      fontSize: 16.sp,
      fontWeight: FontWeight.w500,
      color: MainColors.getTextPrimaryColor(),
      height: 1,
      letterSpacing: 0,
    );
  }
  static TextStyle small500TitleStyle() {
    return GoogleFonts.inter(
      color: MainColors.getTextPrimaryColor(),
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      height: 1,
      letterSpacing: 0,
    );
  }

  static TextStyle small400TitleStyle() {
    return GoogleFonts.inter(
      color: MainColors.getTextPrimaryColor(),
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
      height: 1,
      letterSpacing: 0,
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

  static TextStyle buttonTextStyle({Color? color}){
    return GoogleFonts.inter(
      color: (color==null) ? Color(0XFFF2FEFF) : color,
      fontSize: 20.sp,
      fontWeight: FontWeight.w500,
      height: 1,
      letterSpacing: 0
    );
  }

  static TextStyle cardsTextStyle({Color? color}){
    return GoogleFonts.inter(
        fontSize: 14.sp,
        fontWeight: FontWeight.w700,
        height: 1.4,
        letterSpacing: -0.3,
        color: MainColors.getMainColor()
    );
  }

  static TextStyle simpleHeadLineTextStyle(Color color){
    return GoogleFonts.inter(
      color: color,
        fontSize: 16.sp,
        fontWeight: FontWeight.w500
    );
  }



}
