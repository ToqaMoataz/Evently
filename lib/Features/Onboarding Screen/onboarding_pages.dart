import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:evently/Core/Text%20Styles/app_textstyles.dart';

import '../../Core/Provider/themeProvider.dart';
import '../../Core/assets/images.dart';

class OnboardingPages {
  static List<PageViewModel> getPages(ThemeProvider themeProvider) {


    return [
      PageViewModel(
        title: "Find Events That Inspire You",
        body:
        "Dive into a world of events crafted to fit your unique interests."
            " Whether your into live music, art workshops, professional networking,"
            " or simply discovering new experiences, we have something for everyone."
            "Our curated recommendations will help you explore, connect, and make the most of every opportunity around you.",
        image: Center(
          child: Image(image: AssetImage(AppImages.onboardingImages[0])),
        ),
        decoration: PageDecoration(
          pageColor: Colors.transparent,
          titleTextStyle: AppTextStyles.introTitleStyle(),
          bodyTextStyle: AppTextStyles.introBodyStyle(themeProvider),
        ),
      ),
      PageViewModel(
        title: "Effortless Event Planning",
        body:
        "Take the hassle out of organizing events with our all-in-one planning tools."
            " From setting up invites and managing RSVPs to scheduling reminders and coordinating details,"
            " we’ve got you covered."
            " Plan with ease and focus on what matters – creating an unforgettable experience for you and your guests.",
        image: Center(
          child: Image(image: AssetImage(AppImages.onboardingImages[1])),
        ),
        decoration: PageDecoration(
          pageColor: Colors.transparent,
          titleTextStyle: AppTextStyles.introTitleStyle(),
          bodyTextStyle: AppTextStyles.introBodyStyle(themeProvider),
        ),
      ),
      PageViewModel(
        title: "Connect with Friends & Share Moments",
        body:
        "Make every event memorable by sharing the experience with others."
            " Our platform lets you invite friends, keep everyone in the loop, and celebrate moments together."
            " Capture and share the excitement with your network, so you can relive the highlights and cherish the memories.",
        image: Center(
          child: Image(image: AssetImage(AppImages.onboardingImages[2])),
        ),
        decoration: PageDecoration(
          pageColor: Colors.transparent,
          titleTextStyle: AppTextStyles.introTitleStyle(),
          bodyTextStyle: AppTextStyles.introBodyStyle(themeProvider),
        ),
      ),
    ];
  }
}
