import 'package:easy_localization/easy_localization.dart';
import 'package:evently/Core/App%20Colors/main_colors.dart';
import 'package:evently/Core/Provider/language_setter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:evently/Core/assets/images.dart';
import '../../../../Core/App Routing/routes.dart';
import '../../../../Core/App Text Styles/app_textstyles.dart';
import '../../../../Core/Provider/themeProvider.dart';
import "dart:ui" as ui;



class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider=Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Image(image: AssetImage(AppImages.eventlyHeaderOnboarding)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image(image: AssetImage(AppImages.onboarding)),
              SizedBox(height: 28,),
              Text(
                  "onboarding_introduction_title".tr(),
                  style:AppTextStyles.titleLarge()
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 28),
                child: Text(
                    "onboarding_introduction_subtitle".tr(),
                    style:AppTextStyles.bodyLarge(themeMode: themeProvider.themeMode)
                ),
              ),
              //Language Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "language_text".tr(),
                    style: GoogleFonts.inter(
                      color: MainColors.getMainColor(),
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal,
                      height: 1,
                      letterSpacing: 0,
                    ),
                  ),
                  Directionality(
                    textDirection: ui.TextDirection.ltr,
                    child: Container(
                      width: 75,
                      height: 32,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                          color: MainColors.getMainColor(),
                        ),
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              LanguageChanger.changeLan(context,lang: "language_en");
                            },
                            borderRadius: BorderRadius.circular(100),
                            child: Container(
                              width: 22,
                              height: 22,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: MainColors.getMainColor(),
                                  width: 3,
                                  style: (context.locale.toString()=='en') ? BorderStyle.solid : BorderStyle.none,
                                ),
                              ),
                              child: ClipOval(
                                child: Image.asset(
                                  AppImages.lr,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              LanguageChanger.changeLan(context,lang: "language_ar");
                            },
                            borderRadius: BorderRadius.circular(100.r),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: MainColors.getMainColor(),
                                  width: 3,
                                  style: (context.locale.toString()=='ar') ? BorderStyle.solid : BorderStyle.none,
                                ),
                              ),
                              child: ClipOval(
                                child: Image.asset(
                                  AppImages.eg,
                                  fit: BoxFit.cover,
                                  width: 22,
                                  height: 22,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16,),
              //Theme Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "theme_text".tr(),
                    style: GoogleFonts.inter(
                      color: MainColors.getMainColor(),
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal,
                      height: 1,
                      letterSpacing: 0,
                    ),
                  ),
                  Directionality(
                    textDirection: ui.TextDirection.ltr,
                    child: Container(
                      width: 75,
                      height: 32,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                          color: MainColors.getMainColor(),
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              themeProvider.changeTheme(ThemeMode.light);
                            },
                            borderRadius: BorderRadius.circular(100),
                            child: Container(
                              decoration: BoxDecoration(
                                color: (themeProvider.themeMode==ThemeMode.light) ?  MainColors.getMainColor() :Colors.transparent,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: MainColors.getMainColor(),
                                  style: (themeProvider.themeMode==ThemeMode.light) ? BorderStyle.solid : BorderStyle.none,
                                  width: 3,
                                ),
                              ),
                              child: ClipOval(
                                child: Image.asset(
                                 AppImages.sun,
                                  fit: BoxFit.cover,
                                  color: (themeProvider.themeMode==ThemeMode.light) ? Color(0XFFF2FEFF) : MainColors.getMainColor(),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              themeProvider.changeTheme(ThemeMode.dark);
                            },
                            borderRadius: BorderRadius.circular(100),
                            child: Container(
                              decoration: BoxDecoration(
                                color: (themeProvider.themeMode==ThemeMode.dark) ?  MainColors.getMainColor() : Colors.transparent,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: MainColors.getMainColor(),
                                  style: (themeProvider.themeMode==ThemeMode.dark) ? BorderStyle.solid : BorderStyle.none,
                                  width: 3,
                                ),
                              ),
                              child: ClipOval(
                                child: Image.asset(
                                  AppImages.moon,
                                  fit: BoxFit.cover,
                                  color: (themeProvider.themeMode==ThemeMode.dark) ? MainColors.getLightColor() : MainColors.getMainColor(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h,),
              ElevatedButton(
                  onPressed: (){
                    Navigator.pushReplacementNamed(context, Routes.onboardingScreenRouteName);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor:MainColors.getMainColor()
                  ),
                  child:Text(
                    "onboarding_button".tr(),
                    style:AppTextStyles.buttonTextStyle(),
                    textAlign: TextAlign.center,
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
