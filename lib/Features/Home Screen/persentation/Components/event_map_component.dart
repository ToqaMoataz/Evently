
import 'package:evently/Core/Models/event_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../Core/App Colors/main_colors.dart';
import '../../../../Core/App Routing/routes.dart';
import '../../../../Core/Provider/themeProvider.dart';

class EventMapCard extends StatelessWidget {
  final EventModel event;
  Function resetPosition;
  EventMapCard({super.key, required this.event,required this.resetPosition});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    bool isLightMode = (themeProvider.themeMode == ThemeMode.light);
    return GestureDetector(
      onTap: (){resetPosition();},
      onDoubleTap: (){Navigator.pushNamed(context, Routes.loginScreenRouteName);},
      child: Container(
        height: 94.h,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: MainColors.getMainColor()),
        ),
        child: Row(
          children: [
            Image(image: AssetImage(event.eventCategory)),
            SizedBox(width: 10.w),
            Column(
              children: [
                Text(
                  event.title,
                  style: GoogleFonts.inter(
                    color: MainColors.getMainColor(),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    height: 140,
                    letterSpacing: -0.3,
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color:
                          (isLightMode)
                              ? MainColors.getTDarkColor()
                              : MainColors.getLightColor(),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      event.location,
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: (isLightMode)
                            ? MainColors.getTDarkColor()
                            : MainColors.getLightColor(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
