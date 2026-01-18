
import 'package:easy_localization/easy_localization.dart';
import 'package:evently/Core/Provider/inital_route_provider.dart';
import 'package:evently/Features/Event%20Management/Presentation/Screens/Map%20Screen/map_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:evently/Core/appTheaming.dart';
import 'package:flutter/material.dart';
import 'Core/Dependency Injection/di.dart';
import 'Core/Provider/themeProvider.dart';
import 'Core/routes/routes.dart';
import 'Features/Authentication Screens/Presentation/Screens/Forget Password Screen/forget_password_screen.dart';
import 'Features/Authentication Screens/Presentation/Screens/Login Screen/Login View Model/login_screen.dart';
import 'Features/Authentication Screens/Presentation/Screens/Register Screen/register_screen.dart';
import 'Features/Event Management/Presentation/Screens/Create Event Screen/event_form_event.dart';
import 'Features/Event Management/Presentation/Screens/Event Details Screen/event_details_screen.dart';
import 'Features/Home Screen/persentation/home_Screen.dart';
import 'Features/Introduction Screen/introduction_screen.dart';
import 'Features/Onboarding Screen/onboarding_screen.dart';
import 'Features/Splash Screen/splash_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await EasyLocalization.ensureInitialized();

  configureDependencies();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => ThemeProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => InitialRouteProvider(),
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}


class MyApp extends StatelessWidget {

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 841),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        final themeProvider = context.watch<ThemeProvider>();
        final initialRouteProvider = context.watch<InitialRouteProvider>();
        return MaterialApp(
          theme: AppTheming.lightTheme,
          darkTheme: AppTheming.darkTheme,
          themeMode: themeProvider.themeMode,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          routes: {
            Routes.splashScreenRouteName : (context) => SplashScreen(),
            Routes.introductionScreenRouteName: (context) => IntroScreen(),
            Routes.loginScreenRouteName : (context) => LoginScreen(),
            Routes.registerScreenRouteName : (context) => RegisterScreen(),
            Routes.forgetPasswordScreenRouteName : (context) => ForgetPasswordScreen(),
            Routes.homeScreenRouteName : (context) => HomeScreen(),
            Routes.onboardingScreenRouteName : (context) => OnboardingScreen(),
            Routes.createEventScreenRouteName : (context) => EventFormScreen(),
            Routes.eventDetailsScreenRouteName : (context) => EventDetailsScreen(),
            Routes.mapScreenRouteName: (context) => MapScreen(),
          },
          initialRoute: initialRouteProvider.initialRoute,
          // initialRoute:  Routes.homeScreenRouteName,
        );
      },
    );
  }

}

