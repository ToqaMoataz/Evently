import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Features/Authentication Screens/Presentation/Screens/Login Screen/Screen/login_screen.dart';
import 'routes.dart';
import '../Dependency Injection/di.dart';

import '../../Features/Splash Screen/splash_screen.dart';
import '../../Features/Introduction Screen/Presentation/Screen/introduction_screen.dart';
import '../../Features/Onboarding Screen/Presentation/Screen/onboarding_screen.dart';
import '../../Features/Authentication Screens/Presentation/Screens/Register Screen/Screen/register_screen.dart';
import '../../Features/Authentication Screens/Presentation/Screens/Forget Password Screen/Screen/forget_password_screen.dart';
import '../../Features/Home Screen/persentation/Home Screen/home_Screen.dart';
import '../../Features/Event Management/Presentation/Screens/Create or Update Event/event_form_event.dart';
import '../../Features/Event Management/Presentation/Screens/Map Screen/map_screen.dart';
import '../../Features/Event Management/Presentation/Screens/Event Details Screen/event_details_screen.dart';

import '../../Features/Event Management/Presentation/Cubit/View Models/event_form_view_model.dart';

class AppRouter {
  static final EventFormViewModel _viewModel = getIt<EventFormViewModel>();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
      case Routes.homeScreenRouteName:
        return MaterialPageRoute(builder: (_) => HomeScreen());



      case Routes.introductionScreenRouteName:
        return MaterialPageRoute(builder: (_) => IntroScreen());
      case Routes.splashScreenRouteName:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case Routes.onboardingScreenRouteName:
        return MaterialPageRoute(builder: (_) => OnboardingScreen());

      case Routes.loginScreenRouteName:
        return MaterialPageRoute(builder: (_) => LoginScreen());

      case Routes.registerScreenRouteName:
        return MaterialPageRoute(builder: (_) => RegisterScreen());

      case Routes.forgetPasswordScreenRouteName:
        return MaterialPageRoute(builder: (_) => ForgetPasswordScreen());

      case Routes.formEventScreenRouteName:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider.value(
            value: _viewModel,
            child: EventFormScreen(),
          ),
        );

      case Routes.mapScreenRouteName:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _viewModel,
            child: MapScreen(),
          ),
        );

      case Routes.eventDetailsScreenRouteName:
        return MaterialPageRoute(settings: settings,builder: (_) => EventDetailsScreen());

      default:
        return MaterialPageRoute(
          builder:
              (_) =>
                  const Scaffold(body: Center(child: Text('Page Not Found'))),
        );
    }
  }
}
