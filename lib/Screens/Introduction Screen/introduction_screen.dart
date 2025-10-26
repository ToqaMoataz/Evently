import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:evently/Core/Text%20Styles/app_textstyles.dart';
import 'package:evently/Core/assets/images.dart';
import 'package:evently/Provider/themeProvider.dart';
import "dart:ui" as ui;

import 'package:evently/Screens/Authentication%20Screens/Login%20Screen/Screen/login_screen.dart';

import '../../Core/routes/routes.dart';

class IntroScreen extends StatefulWidget {
  static const String routeName="/introduction";
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<ThemeProvider>(context);
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
              Image(image: AssetImage("assets/images/onboarding.png")),
              SizedBox(height: 28,),
              Text(
                  "onboarding_introduction_title".tr(),
                  style:AppTextStyles.introTitleStyle()
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 28.0),
                child: Text(
                    "onboarding_introduction_subtitle".tr(),
                    style:AppTextStyles.introBodyStyle(provider)
                ),
              ),
              //Language Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "language_text".tr(),
                    style: GoogleFonts.inter(
                      color: Color(0XFF5669FF),
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
                          color: Color(0XFF5669FF),
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              context.setLocale(Locale('en'));
                              setState(() {});
                            },
                            borderRadius: BorderRadius.circular(100),
                            child: Container(
                              width: 22,
                              height: 22,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Color(0XFF5669FF),
                                  width: 3,
                                  style: (context.locale.toString()=='en') ? BorderStyle.solid : BorderStyle.none,
                                ),
                              ),
                              child: ClipOval(
                                child: Image.asset(
                                  "assets/images/LR.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              context.setLocale(Locale('ar'));
                              setState(() {

                              });
                            },
                            borderRadius: BorderRadius.circular(100),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Color(0XFF5669FF),
                                  width: 3,
                                  style: (context.locale.toString()=='ar') ? BorderStyle.solid : BorderStyle.none,
                                ),
                              ),
                              child: ClipOval(
                                child: Image.asset(
                                  "assets/images/EG.png",
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
                      color: Color(0XFF5669FF),
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
                          color: Color(0XFF5669FF),
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              provider.changeTheme(ThemeMode.light);
                            },
                            borderRadius: BorderRadius.circular(100),
                            child: Container(
                              decoration: BoxDecoration(
                                color: (provider.themeMode==ThemeMode.light) ?  Color(0XFF5669FF) :Colors.transparent,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Color(0XFF5669FF),
                                  style: (provider.themeMode==ThemeMode.light) ? BorderStyle.solid : BorderStyle.none,
                                  width: 3,
                                ),
                              ),
                              child: ClipOval(
                                child: Image.asset(
                                  "assets/images/Sun.png",
                                  fit: BoxFit.cover,
                                  color: (provider.themeMode==ThemeMode.light) ? Color(0XFFF2FEFF) : Color(0XFF5669FF),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              provider.changeTheme(ThemeMode.dark);
                            },
                            borderRadius: BorderRadius.circular(100),
                            child: Container(
                              decoration: BoxDecoration(
                                color: (provider.themeMode==ThemeMode.dark) ?  Color(0XFF5669FF) : Colors.transparent,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Color(0XFF5669FF),
                                  style: (provider.themeMode==ThemeMode.dark) ? BorderStyle.solid : BorderStyle.none,
                                  width: 3,
                                ),
                              ),
                              child: ClipOval(
                                child: Image.asset(
                                  "assets/images/Moon.png",
                                  fit: BoxFit.cover,
                                  color: (provider.themeMode==ThemeMode.dark) ? Color(0XFFF2FEFF) : Color(0XFF5669FF),
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
              SizedBox(height: 10,),
              ElevatedButton(
                  onPressed: (){
                    Navigator.pushReplacementNamed(context, Routes.loginScreenRouteName);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0XFF5669FF)
                  ),
                  child:Text(
                    "onboarding_button".tr(),
                    style:GoogleFonts.inter(
                        color: Color(0XFFFFFFFF),
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                        height: 1,
                        letterSpacing: 0
                    ),
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
