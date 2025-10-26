import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
   ThemeMode themeMode=ThemeMode.light;
   // late User user;
   void changeTheme(ThemeMode mode){
     if(themeMode==mode) return;
     themeMode=mode;
     notifyListeners();
   }
}