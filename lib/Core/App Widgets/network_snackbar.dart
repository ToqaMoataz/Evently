import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../../../../Core/App Colors/main_colors.dart';

class NetworkSnackBar {
  static void show(BuildContext scaffoldContext, bool isOnline) {
    ScaffoldMessenger.of(scaffoldContext).showSnackBar(
      SnackBar(
        content: Text(
          isOnline ? "back_online".tr() : "no_internet".tr(),
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: isOnline ? Colors.green : MainColors.getRedColor(),
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
      ),
    );
  }
}
