
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:evently/Core/appTheaming.dart';
import 'package:flutter/material.dart';
import 'Core/Provider/language_provider.dart';
import 'Core/Provider/themeProvider.dart';
import 'Core/routes/routes.dart';
import 'Features/Authentication Screens/Presentation/Screens/Forget Password Screen/forget_password_screen.dart';
import 'Features/Authentication Screens/Presentation/Screens/Login Screen/Login View Model/login_screen.dart';
import 'Features/Authentication Screens/Presentation/Screens/Register Screen/register_screen.dart';
import 'Features/Create Event Screen/create_event.dart';
import 'Features/Edit event Screen/edit_event.dart';
import 'Features/Home Screen/persentation/home_Screen.dart';
import 'Features/Introduction Screen/introduction_screen.dart';
import 'Features/Onboarding Screen/onboarding_screen.dart';
import 'Features/Splash Screen/splash_screen.dart';
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
          child: MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (_) => LanguageProvider(),
              ),
              ChangeNotifierProvider(
                create: (_) => ThemeProvider(),
              ),
            ],

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
            Routes.loginScreenRouteName : (context) => LoginScreen(),
            Routes.registerScreenRouteName : (context) => RegisterScreen(),
            Routes.homeScreenRouteName : (context) => HomeScreen(),
            Routes.onboardingScreenRouteName : (context) => OnboardingScreen(),
            Routes.createEventScreenRouteName : (context) => CreateEventScreen(),
            Routes.editEventScreenRouteName : (context) => EditEventScreen(),
            Routes.forgetPasswordScreenRouteName : (context) => ForgetPasswordScreen(),

          },
          initialRoute:  Routes.homeScreenRouteName,
        );
      },
    );
  }

}

