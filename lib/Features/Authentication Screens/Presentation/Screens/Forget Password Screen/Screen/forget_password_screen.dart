import 'package:easy_localization/easy_localization.dart';
import 'package:evently/Core/App%20Colors/main_colors.dart';
import 'package:evently/Core/Dependency%20Injection/di.dart';
import 'package:evently/Features/Authentication%20Screens/Presentation/Components/text_field_card.dart';
import 'package:evently/Features/Authentication%20Screens/Presentation/Screens/Forget%20Password%20Screen/Cubit/forget_password_viewModel.dart';
import 'package:evently/Features/Authentication%20Screens/Presentation/Screens/Forget%20Password%20Screen/Cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:evently/Core/assets/images.dart';
import '../../../../../../Core/App Routing/routes.dart';
import '../../../../../../Core/App Text Styles/app_textstyles.dart';
import '../../../../../../Core/App Widgets/app_widgets.dart';
import '../../../../../../Core/assets/const data.dart';



class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final ForgetPasswordViewModel viewModel=getIt<ForgetPasswordViewModel>();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("forget_password_button".tr()),
      ),
      body: BlocProvider(
        create: (context)=>viewModel,
        child: BlocConsumer<ForgetPasswordViewModel,ForgetPassState>(
            builder: (context,state){
              return Stack(
                children: [
                  Opacity(
                    opacity: state.opacity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Image(image: AssetImage(AppImages.forgetPassPic)),
                          TextFieldCard(
                            hintText: "email_text".tr(), icon: Icons.email, textController: _emailController,color:MainColors.getGreyColor(),
                          ),
                          SizedBox(height: 24.h,),
                          GestureDetector(
                            onTap: (){
                              viewModel.sendPasswordResetEmail(email:_emailController.text);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 24),
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                decoration: BoxDecoration(
                                    color: MainColors.getMainColor(),
                                    borderRadius: BorderRadius.circular(16.r)
                                ),
                                child: Text(
                                  "reset_password_text".tr(),
                                  style: AppTextStyles.buttonTextStyle(),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if(state.forgetPassRequestState==RequestState.loading)
                    Align(
                      alignment: Alignment.center,
                      child: AppWidgets.loadingCard(context),
                    ),
                  if(state.forgetPassRequestState==RequestState.error)
                    GestureDetector(
                      onTap: (){viewModel.opacityOff();},
                      child: Align(
                        alignment: Alignment.center,
                        child:(state.opacity==1) ? SizedBox.shrink() : AppWidgets.errorCard(context, state.errorMessage ?? ""),
                      ),
                    ),
                ]
              );
            },
            listener: (context,state){
              if(viewModel.state.forgetPassRequestState==RequestState.success){
                Navigator.pushReplacementNamed(context, Routes.loginScreenRouteName);
              }
            }),
      ),
    );
  }
}
