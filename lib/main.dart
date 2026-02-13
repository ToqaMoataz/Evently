
import 'package:easy_localization/easy_localization.dart';
import 'package:evently/Core/Local%20notifications/notifications_manager.dart';
import 'package:evently/Core/Provider/inital_route_provider.dart';
import 'package:evently/Core/App Routing/app_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:evently/Core/App%20Theme/app_theaming.dart';
import 'package:flutter/material.dart';
import 'Core/App Routing/routes.dart';
import 'Core/Dependency Injection/di.dart';
import 'Core/Provider/themeProvider.dart';
import 'Core/Shared Prefrences/shared_pref.dart';
import 'firebase_options.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await EasyLocalization.ensureInitialized();
  await PreferencesHelper.init();
  await NotificationsManager.initNotifications();
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
          navigatorKey: navigatorKey,
          theme: AppTheming.lightTheme,
          darkTheme: AppTheming.darkTheme,
          themeMode: themeProvider.themeMode,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          onGenerateRoute: AppRouter.generateRoute,
          initialRoute: (initialRouteProvider.isLoading || initialRouteProvider.initialRoute == null) ? Routes.splashScreenRouteName : initialRouteProvider.initialRoute,
          // initialRoute:  Routes.homeScreenRouteName,
        );
      },
    );
  }

}

