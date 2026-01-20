
import 'package:easy_localization/easy_localization.dart';
import 'package:evently/Core/Provider/inital_route_provider.dart';
import 'package:evently/Core/App Routing/app_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:evently/Core/App%20Theme/appTheaming.dart';
import 'package:flutter/material.dart';
import 'Core/App Colors/main_colors.dart';
import 'Core/App Routing/routes.dart';
import 'Core/Dependency Injection/di.dart';
import 'Core/Provider/themeProvider.dart';
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
        // final initialRouteProvider = context.watch<InitialRouteProvider>();
        //
        // if (initialRouteProvider.isLoading) {
        //   return MaterialApp(
        //     home: Scaffold(
        //       body: Center(child: CircularProgressIndicator(color: MainColors.getMainColor(),)),
        //     ),
        //   );
        // }
        return MaterialApp(
          theme: AppTheming.lightTheme,
          darkTheme: AppTheming.darkTheme,
          themeMode: themeProvider.themeMode,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          onGenerateRoute: AppRouter.generateRoute,
          // App Routing: {
          //   Routes.splashScreenRouteName : (context) => SplashScreen(),
          //   Routes.introductionScreenRouteName: (context) => IntroScreen(),
          //   Routes.loginScreenRouteName : (context) => LoginScreen(),
          //   Routes.registerScreenRouteName : (context) => RegisterScreen(),
          //   Routes.forgetPasswordScreenRouteName : (context) => ForgetPasswordScreen(),
          //   Routes.homeScreenRouteName : (context) => HomeScreen(),
          //   Routes.onboardingScreenRouteName : (context) => OnboardingScreen(),
          //   Routes.createEventScreenRouteName : (context) => EventFormScreen(),
          //   Routes.eventDetailsScreenRouteName : (context) => EventDetailsScreen(),
          //   Routes.mapScreenRouteName: (context) => MapScreen(),
          // },
          //initialRoute: initialRouteProvider.initialRoute,
          initialRoute:  Routes.homeScreenRouteName,
        );
      },
    );
  }

}

