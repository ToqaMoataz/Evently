import 'package:flutter/material.dart';
import 'package:evently/Core/Color/dark_colors.dart';
import 'package:evently/Core/Color/light_colors.dart';
import 'package:evently/Core/Color/main_colors.dart';
import 'package:evently/Core/Text%20Styles/app_textstyles.dart';

MainColors light=LightColors();
MainColors dark=DarkColors();

class AppTheming{
    static final ThemeData lightTheme=ThemeData(
      scaffoldBackgroundColor: light.getBackgroundColor(),
      appBarTheme: AppBarTheme(
          backgroundColor: light.getAppBarColor(),
          titleTextStyle:AppTextStyles.titleLargeStyle(),
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
          titleTextStyle:AppTextStyles.titleLargeStyle(),
          centerTitle: true,
          iconTheme: IconThemeData(
              color: MainColors.getMainColor(),
              size: 16
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