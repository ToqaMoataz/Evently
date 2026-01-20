import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
          titleTextStyle:AppTextStyles.simpleTitleStyle(),
          centerTitle: true,
          iconTheme: IconThemeData(
            color: MainColors.getMainColor()
          )
        ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: MainColors.getMainColor()
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: MainColors.getMainColor()
      )
    );

    static final ThemeData darkTheme=ThemeData(
      scaffoldBackgroundColor: dark.getBackgroundColor(),
      appBarTheme: AppBarTheme(
          backgroundColor: dark.getAppBarColor(),
          toolbarHeight: 64.h,
          titleTextStyle:AppTextStyles.simpleTitleStyle(),
          centerTitle: true,
          iconTheme: IconThemeData(
              color: MainColors.getMainColor(),
              size: 16.sp
          )
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
         backgroundColor: dark.getAppBarColor()
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: dark.getAppBarColor()
      )
    );
}