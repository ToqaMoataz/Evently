import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../App Colors/dark_colors.dart';
import '../App Colors/light_colors.dart';
import '../App Colors/main_colors.dart';
import '../App Text Styles/app_textstyles.dart';

MainColors light=LightColors();
MainColors dark=DarkColors();

class AppTheming{
    static final ThemeData lightTheme=ThemeData(
      scaffoldBackgroundColor: light.getBackgroundColor(),
      appBarTheme: AppBarTheme(
          backgroundColor: light.getAppBarColor(),
          toolbarHeight: 64.h,
          titleTextStyle:AppTextStyles.appbarTitle(),
          centerTitle: true,
          iconTheme: IconThemeData(
            color: MainColors.getMainColor()
          )
        ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: MainColors.getMainColor(),
        selectedLabelStyle: GoogleFonts.inter(
          color: MainColors.getLightColor(),
          fontSize: 12.sp,
          fontWeight: FontWeight.w700,
          height: 1,
          letterSpacing: 0,
        ),
        type: BottomNavigationBarType.fixed,
        unselectedItemColor:MainColors.getLightColor(),
        selectedItemColor:MainColors.getLightColor(),
        showSelectedLabels: true,
        showUnselectedLabels: true
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: MainColors.getMainColor()
      ),
    );

    static final ThemeData darkTheme=ThemeData(
      scaffoldBackgroundColor: dark.getBackgroundColor(),
      appBarTheme: AppBarTheme(
          backgroundColor: dark.getAppBarColor(),
          toolbarHeight: 64.h,
          titleTextStyle:AppTextStyles.appbarTitle(),
          centerTitle: true,
          iconTheme: IconThemeData(
              color: MainColors.getMainColor(),
              size: 16.sp
          )
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
         backgroundColor: dark.getAppBarColor(),
          selectedLabelStyle: GoogleFonts.inter(
            color: MainColors.getLightColor(),
            fontSize: 12.sp,
            fontWeight: FontWeight.w700,
            height: 1,
            letterSpacing: 0,
          ),
          type: BottomNavigationBarType.fixed,
          unselectedItemColor:MainColors.getLightColor(),
          selectedItemColor:MainColors.getLightColor(),
          showSelectedLabels: true,
          showUnselectedLabels: true
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: dark.getAppBarColor()
      )
    );
}