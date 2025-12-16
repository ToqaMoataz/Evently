import 'package:evently/Core/Color/main_colors.dart';
import 'package:evently/Core/Text%20Styles/app_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ProfileTab extends StatefulWidget {
  ProfileTab( {super.key});
  // late ThemeProvider themeProvider;

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 175.h,
        shape:RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(64.r)
          )
        ),
        backgroundColor: MainColors.getMainColor(),
        title: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              //User Image
              SizedBox(
                height: 124.w,
                width: 124.w,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft:Radius.circular(24.r) ,
                    topRight: Radius.circular(1000.r),
                    bottomLeft: Radius.circular(1000.r),
                    bottomRight: Radius.circular(1000.r),
                  ),
                  child: Image(image: AssetImage("assets/images/user.png")),
                ),
              ),
              SizedBox(width: 16.w,),
              // User name and mail
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "John Safwat",
                      style: AppTextStyles.largeTitleStyle()
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      "johnsafwat.route@gmail.com",
                      style: AppTextStyles.mediumTitleStyle(),
                      softWrap: true,
                      overflow: TextOverflow.clip,
                    ),
                  ],
                ),
              )

            ],
          ),
        ),
      ),
      body: Column(
        children: [

        ],
      ),
    );
  }
}
