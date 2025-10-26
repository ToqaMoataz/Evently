
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:evently/Core/appTheaming.dart';
import 'package:evently/Provider/themeProvider.dart';
import 'package:evently/Screens/Authentication%20Screens/Forget%20Password%20Screen/forget_password_screen.dart';
import 'package:evently/Screens/Introduction%20Screen/introduction_screen.dart';
import 'package:flutter/material.dart';
import 'package:evently/Screens/Onboarding%20Screen/onboarding_screen.dart';
import 'package:evently/Screens/Splash%20Screen/splash_screen.dart';

import 'Core/routes/routes.dart';
import 'Screens/Edit event Screen/edit_event.dart';
import 'Screens/Home Screen/home_Screen.dart';
import 'Screens/Create Event Screen/create_event.dart';
import 'Screens/Authentication Screens/Login Screen/Screen/login_screen.dart';
import 'Screens/Authentication Screens/Register Screen/register_screen.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  //await FirebaseFirestore.instance.disableNetwork();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await EasyLocalization.ensureInitialized();
  runApp(
      EasyLocalization(
          supportedLocales: [Locale('en'), Locale('ar')],
          path: 'assets/translations', // <-- change the path of the translation files
          fallbackLocale: Locale('en'),
          child: ChangeNotifierProvider(
            create: (context)=>ThemeProvider(),
            child: MyApp()
          )
      )
  );
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ThemeProvider>(context);
    return ScreenUtilInit(
      designSize: const Size(393, 841),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          theme: AppTheming.lightTheme,
          darkTheme: AppTheming.darkTheme,
          themeMode: provider.themeMode,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          title: 'Flutter Demo',
          routes: {
            Routes.splashScreenRouteName : (context) => SplashScreen(),
            Routes.introductionScreenRouteName: (context) => IntroScreen(),
            Routes.loginScreenRouteName: (context) => LoginScreen(),
            Routes.registerScreenRouteName: (context) => RegisterScreen(),
            Routes.homeScreenRouteName: (context) => HomeScreen(),
            Routes.onboardingScreenRouteName: (context) => OnboardingScreen(),
            Routes.createEventScreenRouteName: (context) => CreateEventScreen(),
            Routes.editEventScreenRouteName: (context) => EditEventScreen(),
            Routes.forgetPasswordScreenRouteName : (context) => ForgetPasswordScreen()
          },
          initialRoute: Routes.loginScreenRouteName,
        );
      },
    );
  }

}

