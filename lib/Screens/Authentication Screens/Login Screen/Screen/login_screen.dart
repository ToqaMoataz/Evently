import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:evently/Core/assets/images.dart';
import 'package:evently/Firebase/firebase_manager.dart';
import 'package:evently/Models/user_model.dart';
import 'package:evently/Screens/Authentication%20Screens/Register%20Screen/register_screen.dart';

import '../../../../Core/routes/routes.dart';
import '../../../Home Screen/home_Screen.dart';
import '../../Components/text_field_card.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool passwordVisible = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose(){
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          spacing: 24.h,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //Logo
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Image(
                 image: AssetImage(AppImages.eventlyLogo),
                 height: 136.h,
                width: 186.w,
              ),
            ),

            SizedBox(
              child: Column(
                children: [
                  // Email TextField
                  TextFieldCard(
                    hintText:"email_text".tr(),
                    icon: Icons.mail_rounded,
                    textController: _emailController,
                    validate:(value){
                      if(value==null||value.isEmpty){
                        return "Email is required";
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 16.h),

                  // Password TextField
                  TextFieldCard(
                    hintText:"password_text".tr(),
                    icon: Icons.lock,
                    textController: _passwordController,
                    isPass: true,
                    passVisible: passwordVisible,
                    onVisibilityToggle: () {
                      setState(() {
                        passwordVisible = !passwordVisible;
                      });
                    },
                  ),
                  //forgot password
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(onPressed: (){
                        Navigator.pushNamed(context, Routes.forgetPasswordScreenRouteName);
                      },
                      child: Text(
                            "forget_password_text".tr(),
                            style: GoogleFonts.inter(
                              color: Color(0XFF5669FF),
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.italic,
                              decoration: TextDecoration.underline,
                              decorationColor: Color(0XFF5669FF),
                              decorationStyle: TextDecorationStyle.solid,
                            ),
                          )
                      ),
                    ],
                  ),
                ],
              ),
            ),
            //login button
            GestureDetector(
              onTap: (){


              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: Color(0XFF5669FF),
                  borderRadius: BorderRadius.circular(16.r)
                ),
                child: Text(
                  "login_text".tr(),
                  style: GoogleFonts.inter(
                    fontSize: 20.sp,
                    color: Color(0XFFFFFFFF),
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            // create account
            Text.rich(
              TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: "no_account_text".tr(),
                    style: GoogleFonts.inter(
                      color: Colors.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      //fontStyle: FontStyle.italic,
                    )
                  ),
                  TextSpan(
                    text: "create_account_text".tr(),
                    style: GoogleFonts.inter(
                      color: Color(0XFF5669FF),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.italic,
                      height: 1.h,
                      letterSpacing: 0,
                      decoration: TextDecoration.underline,
                      decorationColor: Color(0XFF5669FF),
                      decorationStyle: TextDecorationStyle.solid,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pushReplacementNamed(context, Routes.registerScreenRouteName); // Replace with your route
                      },
                  ),

                ],
              ),
            ),
            // --- Or separator Row ---
            Row(
              children: [
                const Expanded(
                  child: Divider(
                    color: Color(0XFF5669FF),
                    thickness: 1,
                    indent: 20,
                    endIndent: 10,
                  ),
                ),
                Text(
                  "or_text".tr(),
                  style: TextStyle(
                    color: Color(0XFF5669FF),
                    fontSize: 16.sp,
                  ),
                ),
                const Expanded(
                  child: Divider(
                    color: Color(0XFF5669FF),
                    thickness: 1,
                    indent: 10,
                    endIndent: 20,
                  ),
                ),
              ],
            ),
            //Google login
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Color(0XFF5669FF), width: 1),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage("assets/images/google_icon.png"),
                    height: 24,
                    width: 24,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "google_login_text".tr(),
                    style: TextStyle(
                      color: Color(0XFF5669FF),
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                            setState(() {

                            });
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
                                AppImages.lr,
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
          ],
        ),
      ),
    );
  }
}
