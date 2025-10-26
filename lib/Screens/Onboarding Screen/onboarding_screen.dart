import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';
import 'package:evently/Core/Color/main_colors.dart';
import 'package:evently/Screens/Onboarding%20Screen/onboarding_pages.dart';

import '../../Core/assets/images.dart';
import '../../Core/routes/routes.dart';
import '../../Provider/themeProvider.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

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
                  color: (themeProvider.themeMode == ThemeMode.light) ? MainColors.getSecondaryColor() : Colors.white,
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
