import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {

  void changeLan(BuildContext context) {
    if (context.locale.languageCode == 'ar') {
      context.setLocale(const Locale('en'));
    } else {
      context.setLocale(const Locale('ar'));
    }
    notifyListeners();
  }
}
