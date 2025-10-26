import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:evently/Core/assets/images.dart';

import '../Components/text_field_card.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose(){
    super.dispose();
    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forget Password"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image(image: AssetImage(AppImages.forgetPassPic)),
            SizedBox(height: 24.h,),
            TextFieldCard(
              hintText:"email_text".tr(),
              icon: Icons.mail_rounded,
              textController: _emailController,
              validate:(value){
                if(value==null||value.isEmpty){
                  return "Email is required";
                }
                return null;
              },
            ),
            GestureDetector(
              onTap: (){


              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                      color: Color(0XFF5669FF),
                      borderRadius: BorderRadius.circular(16.r)
                  ),
                  child: Text(
                    "reset_password_text".tr(),
                    style: GoogleFonts.inter(
                      fontSize: 20.sp,
                      color: Color(0XFFFFFFFF),
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
