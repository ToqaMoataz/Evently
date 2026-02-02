import 'package:evently/Core/Dependency%20Injection/di.dart';
import 'package:evently/Features/Onboarding%20Screen/Presentation/View%20Model/view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';

import '../../../../Core/App Colors/main_colors.dart';
import '../../../../Core/App Routing/routes.dart';
import '../../../../Core/Provider/themeProvider.dart';
import '../../../../Core/assets/images.dart';
import '../../data/Const Widgets/onboarding_pages.dart';


class OnboardingScreen extends StatelessWidget {
  final OnboardingViewModel viewModel=getIt<OnboardingViewModel>();
  OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(right: 16,left:16,top: 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image(image: AssetImage(AppImages.eventlyHeaderOnboarding)),
            Expanded(
              child: IntroductionScreen(
                dotsDecorator: DotsDecorator(
                  color: (themeProvider.themeMode == ThemeMode.light) ? MainColors.getTDarkColor() : MainColors.getLightColor(),
                  activeColor: MainColors.getMainColor(),
                  shape: CircleBorder(),
                  activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(36.r),
                  ),
                  activeSize: Size(21, 8)
                ),
                pages: OnboardingPages.getPages(themeProvider),
                back: Container(
                  height: 38.h,
                  width: 38.w,
                  //padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: MainColors.getMainColor(),),
                    borderRadius: BorderRadius.circular(25.r),
                  ),
                  child: Icon(Icons.arrow_back,color: MainColors.getMainColor(),),
                ),
                showBackButton: true,

                next: Container(
                  height: 38.h,
                  width: 38.w,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: MainColors.getMainColor(),),
                    borderRadius: BorderRadius.circular(25.r),
                  ),
                  child: Icon(Icons.arrow_forward,color: MainColors.getMainColor(),),
                ),
                done: Container(
                  height: 38.h,
                  width: 38.w,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: MainColors.getMainColor(),),
                    borderRadius: BorderRadius.circular(25.r),
                  ),
                  child: Icon(Icons.arrow_forward,color: MainColors.getMainColor(),),
                ),
                onDone: (){
                  viewModel.setOnboardingSeen();
                  Navigator.pushNamed(context, Routes.loginScreenRouteName);
                },
              ),
            ),
          ],
        ),
      )
    );
  }
}
