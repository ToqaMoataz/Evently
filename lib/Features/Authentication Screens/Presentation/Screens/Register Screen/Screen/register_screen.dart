import 'dart:ui' as ui;
import 'package:easy_localization/easy_localization.dart';
import 'package:evently/Core/App%20Colors/main_colors.dart';
import 'package:evently/Core/App%20Widgets/app_widgets.dart';
import 'package:evently/Core/Dependency%20Injection/di.dart';
import 'package:evently/Features/Authentication%20Screens/Presentation/Screens/Register%20Screen/Cubit/register_view_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:evently/Core/assets/images.dart';
import 'package:provider/provider.dart';
import '../../../../../../Core/App Routing/routes.dart';
import '../../../../../../Core/App Text Styles/app_textstyles.dart';
import '../../../../../../Core/App Widgets/network_snackbar.dart';
import '../../../../../../Core/Models/user_model.dart';
import '../../../../../../Core/Provider/network_info_provider.dart';
import '../../../../../../Core/Provider/themeProvider.dart';
import '../../../../../../Core/assets/const data.dart';
import '../../../Components/text_field_card.dart';
import '../Cubit/states.dart';

class RegisterScreen extends StatefulWidget {

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _rePasswordController;
  late TextEditingController _phoneController;

  final RegisterViewModel viewModel=getIt<RegisterViewModel>();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _rePasswordController = TextEditingController();
    _phoneController = TextEditingController();
  }

  @override
  void dispose(){
    super.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _rePasswordController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var networkProvider = (context).watch<NetworkProvider>();
    var themeProvider = (context).watch<ThemeProvider>();
    return BlocProvider(
      create: (context) => viewModel,
      child: BlocConsumer<RegisterViewModel,RegisterState>(
        builder: (context, state) {
          return Stack(
            children: [
              Opacity(
                opacity: state.opacity,
                child: Scaffold(
                    resizeToAvoidBottomInset: false,
                    appBar: AppBar(
                      leading: Icon(Icons.arrow_back,color: MainColors.getMainColor(),),
                      title: Text(
                        "register_heading".tr(),
                      ),
                      centerTitle: true,
                    ),
                    body: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          spacing: 16.h,
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
                            //name textfield
                            TextFieldCard(
                              hintText:"name_text".tr(),
                              icon: Icons.person,
                              textController: _nameController,
                              validate:(value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "name_required_text".tr();
                                }
                                return null;
                              },
                            ),
                            //phone textfield
                            TextFieldCard(
                              hintText:"mobile_number_text".tr(),
                              icon: Icons.phone_android_rounded,
                              textController: _phoneController,
                              validate:(value) {
                                final RegExp phoneRegex = RegExp(r'^[0-9]{10,15}$');
                                if (value == null || value.trim().isEmpty) {
                                  return "phone_required_text".tr();
                                } else if (!phoneRegex.hasMatch(value.trim())) {
                                  return "valid_phone_text".tr();
                                }
                                return null;
                              },
                            ),
                            // Email TextField
                            TextFieldCard(
                              hintText:"email_text".tr(),
                              icon: Icons.mail_rounded,
                              textController: _emailController,
                              validate:(value){
                                final RegExp emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.(com)$');
                                if(value==null||value.isEmpty){
                                  return "email_required_text".tr();
                                }
                                else if(!emailRegex.hasMatch(value)){
                                  return "email_not_valid_text".tr();
                                }
                                return null;
                              },
                            ),
                            // Password TextField
                            TextFieldCard(
                              hintText:"password_text".tr(),
                              icon: Icons.lock,
                              textController: _passwordController,
                              validate:(value) {
                                if (value == null || value.isEmpty) {
                                  return "password_required_text".tr();
                                } else if (value.length < 6) {
                                  return "password_length_text".tr();
                                }
                                return null;
                              },
                              isPass: true,
                              passVisible: state.passVisible,
                              onVisibilityToggle: () {
                                viewModel.togglePasswordVisibility();
                              },
                            ),
                            // Re Password TextField
                            TextFieldCard(
                              hintText:"re_password_text".tr(),
                              icon: Icons.lock,
                              textController: _rePasswordController,
                              validate:(value) {
                                if (value == null || value.isEmpty) {
                                  return "confirm_password_text".tr();
                                } else if (value != _passwordController.text) {
                                  return "passwords_not_match_text".tr();
                                }
                                return null;
                              },
                              isPass: true,
                              passVisible: state.rePassVisible,
                              onVisibilityToggle: () {
                                viewModel.toggleRePasswordVisibility();
                              },
                            ),
                            //create account button
                            GestureDetector(
                              onTap: (){
                                if (networkProvider.isOnline) {
                                  if (_formKey.currentState!.validate()) {
                                    UserModel user=UserModel(name: _nameController.text,
                                        email: _emailController.text,
                                        phone: _phoneController.text);
                                    viewModel.createAcc(user: user, password: _passwordController.text);
                                  }
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
                                  "create_account_text".tr(),
                                  style:AppTextStyles.buttonTextStyle(),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            // create account
                            Align(
                              alignment: Alignment.center,
                              child: Text.rich(
                                TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: "already_have_account_text".tr(),
                                        style: GoogleFonts.inter(
                                          color: (themeProvider.themeMode==ThemeMode.light) ? MainColors.getDarkColor() : MainColors.getLightColor(),
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
                                          height: 1.h,
                                          letterSpacing: 0,
                                        )
                                    ),
                                    TextSpan(
                                      text: "login_text".tr(),
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
                                          Navigator.pushReplacementNamed(context, Routes.loginScreenRouteName);
                                        },
                                    ),

                                  ],
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Directionality(
                                  textDirection: ui.TextDirection.ltr,
                                  child: Container(
                                    width: 75.w,
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
                                                color:MainColors.getMainColor(),
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
                                                color: MainColors.getMainColor(),
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
              ),
              if(state.registerRequestState==RequestState.loading)
                Align(
                  alignment: Alignment.center,
                  child: AppWidgets.loadingCard(context),
                ),
              if(state.registerRequestState==RequestState.error)
                GestureDetector(
                  onTap: (){viewModel.opacityOff();},
                  child: Align(
                    alignment: Alignment.center,
                    child:(state.opacity==1) ? SizedBox.shrink() : AppWidgets.errorCard(context, state.errorMessage ?? ""),
                  ),
                ),
            ],
          );
      }, listener:(context, state) {
        if(state.registerRequestState==RequestState.success){
          Navigator.pushReplacementNamed(context, Routes.loginScreenRouteName);
        }
      },)
    );
  }
}
