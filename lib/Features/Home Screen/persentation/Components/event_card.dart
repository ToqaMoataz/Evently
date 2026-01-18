import 'package:easy_localization/easy_localization.dart';
import 'package:evently/Core/Models/event_model.dart';
import 'package:evently/Core/Provider/themeProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../Core/Color/main_colors.dart';
import '../../../../Core/routes/routes.dart';


class EventCard extends StatelessWidget {
  final EventModel event;
  Function updateFav;
  EventCard({super.key,required this.event,required this.updateFav});

  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<ThemeProvider>(context);
    bool isLightTheme=(provider.themeMode==ThemeMode.light);
    String day = DateFormat('d').format(DateTime.fromMillisecondsSinceEpoch(event.date));
    String month = DateFormat('MMM').format(DateTime.fromMillisecondsSinceEpoch(event.date));
    return GestureDetector(
      onTap: (){
       Navigator.pushNamed(context,Routes.eventDetailsScreenRouteName,arguments: event);
      },
      child: ClipRRect(
        borderRadius: BorderRadiusGeometry.circular(16.r),
        child: Container(
          height: 200.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: MainColors.getMainColor()
            )
          ),
          child: Stack(
            children: [
              Positioned.fill(
                  child: Image(
                    image: AssetImage("assets/images/${event.eventCategory}.png"),
                    fit: BoxFit.cover,
                  ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0,left: 8),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: (isLightTheme) ? MainColors.getLightColor() : MainColors.getTDarkColor(),
                          borderRadius: BorderRadius.circular(8.r)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            day,
                            style: GoogleFonts.inter(
                              color: MainColors.getMainColor(),
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700,

                            ),
                          ),
                          SizedBox(height: 2.h,),
                          Text(
                            month,
                            style: GoogleFonts.inter(
                                color: MainColors.getMainColor(),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                                height: 1,
                                letterSpacing: 0
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Container(
                      height: 40.h,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          color: (isLightTheme) ? MainColors.getLightColor() : MainColors.getTDarkColor(),
                          borderRadius: BorderRadius.circular(8.r)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            event.title,
                            style: GoogleFonts.inter(
                                color: (isLightTheme) ? MainColors.getTextSecondaryColor() : MainColors.getTextPrimaryColor(),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                                height: 1,
                                letterSpacing:0
                            ),
                          ),
                          IconButton(
                            onPressed: (){
                              updateFav();
                            },
                            icon:(event.isFav==true) ? Icon(Icons.favorite, color: MainColors.getMainColor()) : Icon(Icons.favorite_border, color: MainColors.getMainColor()),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h,)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  String formatDateFromMillis(int millis) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(millis);
    return DateFormat('d MMMM yyyy').format(date);
  }
}
