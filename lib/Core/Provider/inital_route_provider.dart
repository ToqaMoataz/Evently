import 'package:flutter/cupertino.dart';

import '../App Routing/routes.dart';
import '../Shared Prefrences/shared_pref.dart';

class InitialRouteProvider extends ChangeNotifier {
  late String initialRoute;
  bool isLoading=true;
  InitialRouteProvider(){
    getInitialRoute();
  }

  Future<void> getInitialRoute()async {
    await PreferencesHelper.init();
    bool initialOnboardingSeen=PreferencesHelper.isOnboardingSeen();
    String? userId = PreferencesHelper.getActiveUser();

    if (!initialOnboardingSeen) {
      initialRoute = Routes.introductionScreenRouteName;
    } else if (userId != null) {
      initialRoute = Routes.homeScreenRouteName;
    } else {
      initialRoute = Routes.loginScreenRouteName;
    }
    isLoading=false;
    notifyListeners();
  }
}