import 'package:flutter/material.dart';
import 'package:evently/Core/assets/images.dart';

import '../../Core/routes/routes.dart';

class SplashScreen extends StatefulWidget {

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();
     Future.delayed(Duration(seconds: 3),(){
       Navigator.pushReplacementNamed(context, Routes.loginScreenRouteName);
     });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image(image: AssetImage(AppImages.eventlyLogo)),
          Spacer(),
          Image(image: AssetImage(AppImages.eventlyBranding))
        ],
      ),
    );
  }
}
