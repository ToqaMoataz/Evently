import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../../../../Core/App Text Styles/app_textstyles.dart';
import '../../../../Core/Provider/themeProvider.dart';
import '../../../../Core/assets/images.dart';

class OnboardingPages {
  static List<PageViewModel> getPages(ThemeProvider themeProvider) {
    return [
      PageViewModel(
        title: "onboarding_title_1".tr(),
        body: "onboarding_body_1".tr(),
        image: Center(
          child: Image(image: AssetImage(AppImages.onboardingImages[0])),
        ),
        decoration: PageDecoration(
          pageColor: Colors.transparent,
          titleTextStyle: AppTextStyles.titleLarge(),
          bodyTextStyle: AppTextStyles.bodyLarge(
            themeMode: themeProvider.themeMode,
          ),
        ),
      ),
      PageViewModel(
        title: "onboarding_title_2".tr(),
        body: "onboarding_body_2".tr(),
        image: Center(
          child: Image(image: AssetImage(AppImages.onboardingImages[1])),
        ),
        decoration: PageDecoration(
          pageColor: Colors.transparent,
          titleTextStyle: AppTextStyles.titleLarge(),
          bodyTextStyle: AppTextStyles.bodyLarge(
            themeMode: themeProvider.themeMode,
          ),
        ),
      ),
      PageViewModel(
        title: "onboarding_title_3".tr(),
        body: "onboarding_body_3".tr(),
        image: Center(
          child: Image(image: AssetImage(AppImages.onboardingImages[2])),
        ),
        decoration: PageDecoration(
          pageColor: Colors.transparent,
          titleTextStyle: AppTextStyles.titleLarge(),
          bodyTextStyle: AppTextStyles.bodyLarge(
            themeMode: themeProvider.themeMode,
          ),
        ),
      ),
    ];
  }
}
