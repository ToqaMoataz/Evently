import 'package:evently/Core/assets/const%20data.dart';

class AppImages {
  static const List<String> onboardingImages = [
    "assets/images/being-creative1.png",
    "assets/images/being-creative2.png",
    "assets/images/being-creative3.png",
  ];

  static const String occasions = "assets/images/Categories/Occasions.png";
  static const String birthday = "assets/images/Categories/Birthday.png";
  static const String bookClub = "assets/images/Categories/Book Club.png";
  static const String holiday = "assets/images/Categories/Holiday.png";
  static const String gaming = "assets/images/Categories/Gaming.png";
  static const String eating = "assets/images/Categories/Eating.png";
  static const String workshop = "assets/images/Categories/Workshop.png";
  static const String meeting = "assets/images/Categories/Meeting.png";
  static const String sport = "assets/images/Categories/Sport.png";
  static const String exhibition = "assets/images/Categories/Exhibition.png";

  static const String eg = "assets/images/EG.png";
  static const String lr = "assets/images/LR.png";

  static const String onboarding = "assets/images/onboarding.png";
  static const String eventlyHeaderOnboarding = "assets/images/evently_header_onboarding.png";

  static const String eventlyLogo = "assets/images/evently_logo.png";
  static const String eventlyBranding = "assets/images/Branding.png";

  static const String googleIcon = "assets/images/google_icon.png";
  static const String locationIcon = "assets/images/location icon.png";

  static const String sun = "assets/images/Sun.png";
  static const String moon = "assets/images/Moon.png";

  static const String forgetPassPic = "assets/images/forget password.png";

  static String returnEventImage(String event){
    if(event==AppData.events[1]){
      return bookClub;
    }
    else if(event==AppData.events[2]){
      return sport;
    }
    else if(event==AppData.events[3]){
      return birthday;
    }
    else if(event==AppData.events[4]){
      return eating;
    }
    else if(event==AppData.events[5]){
      return meeting;
    }
    else if(event==AppData.events[6]){
      return workshop;
    }
    else if(event==AppData.events[7]){
      return holiday;
    }
    else if(event==AppData.events[8]){
      return gaming;
    }
    else if(event==AppData.events[9]){
      return occasions;
    }
    return exhibition;
  }

}
