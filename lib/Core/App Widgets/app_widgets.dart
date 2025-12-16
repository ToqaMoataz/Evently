
import 'package:evently/Core/Color/main_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../Provider/themeProvider.dart';

class AppWidgets {

  static Widget loadingCard(BuildContext context) {
    var provider = Provider.of<ThemeProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        height:MediaQuery.of(context).size.height/8,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: (provider.themeMode==ThemeMode.light) ? Color(0XFFF2FEFF) : Color(0XFF101127),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: MainColors.getMainColor(),
            width: 2,
          )
        ),
        child: CircularProgressIndicator(
          color: MainColors.getMainColor(),
        ),
      ),
    );
  }

  static Widget errorCard(BuildContext context,String errorMessage) {
    var provider = Provider.of<ThemeProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        height:MediaQuery.of(context).size.height/8,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
            color: (provider.themeMode==ThemeMode.light) ? Color(0XFFF2FEFF) : Color(0XFF101127),
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(
              color: MainColors.getMainColor(),
              width: 2,
            )
        ),
        child: Text(
          errorMessage,
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
            height: 1.4,
            letterSpacing: -0.3,
            color: MainColors.getMainColor()
          )
          ,
        )
      ),
    );
  }
}
