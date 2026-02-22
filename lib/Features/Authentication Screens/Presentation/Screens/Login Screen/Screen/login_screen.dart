import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:evently/Core/Dependency%20Injection/di.dart';
import 'package:evently/Core/Provider/themeProvider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:evently/Core/assets/images.dart';
import 'package:provider/provider.dart';

import '../../../../../../../Core/App Colors/main_colors.dart';
import '../../../../../../../Core/App Routing/routes.dart';
import '../../../../../../../Core/App Text Styles/app_textstyles.dart';
import '../../../../../../../Core/App Widgets/app_widgets.dart';

import '../../../../../../../Core/assets/const data.dart';

import '../../../../../../Core/App Widgets/network_snackbar.dart';
import '../../../../../../Core/Provider/network_info_provider.dart';
import '../../../Components/text_field_card.dart';
import '../Cubit/login view model.dart';
import '../Cubit/states.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final LoginViewModel viewModel=getIt<LoginViewModel>();
  @override
  void dispose(){
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var networkProvider=Provider.of<NetworkProvider>(context);
    var themeProvider=Provider.of<ThemeProvider>(context);
    return BlocProvider(
      create: (context)=> viewModel,
      child: BlocConsumer<LoginViewModel,LoginState>(
          builder: (context,state){
            return Stack(
              children: [
                Opacity(
                  opacity: state.opacity,
                  child: Scaffold(
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
                                      return "email_required_text".tr();
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
                                  passVisible: state.passwordVisible,
                                  onVisibilityToggle: () {
                                    viewModel.togglePasswordVisibility();
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
                                            color: MainColors.getMainColor(),
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w700,
                                            fontStyle: FontStyle.italic,
                                            decoration: TextDecoration.underline,
                                            decorationColor: MainColors.getMainColor(),
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
                              if (networkProvider.isOnline) {
                                viewModel.login(
                                  _emailController.text,
                                  _passwordController.text,
                                );
                              } else {
                                NetworkSnackBar.show(context, false);
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              decoration: BoxDecoration(
                                  color: MainColors.getMainColor(),
                                  borderRadius: BorderRadius.circular(16.r)
                              ),
                              child: Text(
                                "login_text".tr(),
                                style: AppTextStyles.buttonTextStyle(),
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
                                      color: (themeProvider.themeMode==ThemeMode.light) ? MainColors.getDarkColor() : MainColors.getLightColor(),
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                    )
                                ),
                                TextSpan(
                                  text: "create_account_text".tr(),
                                  style: GoogleFonts.inter(
                                    color: MainColors.getMainColor(),
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.italic,
                                    height: 1.h,
                                    letterSpacing: 0,
                                    decoration: TextDecoration.underline,
                                    decorationColor: MainColors.getMainColor(),
                                    decorationStyle: TextDecorationStyle.solid,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.pushReplacementNamed(context, Routes.registerScreenRouteName);
                                    },
                                ),

                              ],
                            ),
                          ),
                          // --- Or separator Row ---
                          Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  color: MainColors.getMainColor(),
                                  thickness: 1,
                                  indent: 20,
                                  endIndent: 10,
                                ),
                              ),
                              Text(
                                "or_text".tr(),
                                style: TextStyle(
                                  color: MainColors.getMainColor(),
                                  fontSize: 16.sp,
                                ),
                              ),
                              Expanded(
                                child: Divider(
                                  color: MainColors.getMainColor(),
                                  thickness: 1,
                                  indent: 10,
                                  endIndent: 20,
                                ),
                              ),
                            ],
                          ),
                          //Google login
                          // Container(
                          //   padding: const EdgeInsets.symmetric(vertical: 12),
                          //   decoration: BoxDecoration(
                          //     border: Border.all(color: MainColors.getMainColor()),
                          //     borderRadius: BorderRadius.circular(16.r),
                          //   ),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.center,
                          //     children: [
                          //       Image(
                          //         image: AssetImage(AppImages.googleIcon),
                          //         height: 24,
                          //         width: 24,
                          //       ),
                          //       SizedBox(width: 10.w),
                          //       Text(
                          //         "google_login_text".tr(),
                          //         style: AppTextStyles.buttonTextStyle(color:MainColors.getMainColor()),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Directionality(
                                textDirection: ui.TextDirection.ltr,
                                child: Container(
                                  width: 75 .w,
                                  height: 32.h,
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
                                          context.setLocale(Locale('en'));
                                        },
                                        borderRadius: BorderRadius.circular(100.r),
                                        child: Container(
                                          width: 22.w,
                                          height: 22.h,
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
                                          context.setLocale(Locale('ar'));
                                        },
                                        borderRadius: BorderRadius.circular(100.r),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color:MainColors.getMainColor(),
                                              width: 3,
                                              style: (context.locale.toString()=='ar') ? BorderStyle.solid : BorderStyle.none,
                                            ),
                                          ),
                                          child: ClipOval(
                                            child: Image.asset(
                                              AppImages.eg,
                                              fit: BoxFit.cover,
                                              width: 22.w,
                                              height: 22.h,
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
                  ),
                ),
                if(state.loginRequestState==RequestState.loading)
                  Align(
                    alignment: Alignment.center,
                    child: AppWidgets.loadingCard(context),
                  ),
                if(state.loginRequestState==RequestState.error)
                  GestureDetector(
                    onTap: (){viewModel.opacityOff();},
                    child: Align(
                      alignment: Alignment.center,
                      child:(state.opacity==1) ? SizedBox.shrink() : AppWidgets.errorCard(context, state.errorMessage ?? "something_went_wrong_text".tr()),
                    ),
                  ),
              ],
            );
          },
          listener: (context,state){
            if(state.loginRequestState==RequestState.success){
              Navigator.pushReplacementNamed(context, Routes.homeScreenRouteName);
            }
          }
      ),
    );
  }
}
