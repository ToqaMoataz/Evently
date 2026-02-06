
import 'package:evently/Core/App%20Text%20Styles/app_textstyles.dart';
import 'package:evently/Core/Models/event_model.dart';
import 'package:evently/Core/assets/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../Core/App Colors/main_colors.dart';
import '../../../../Core/App Routing/routes.dart';
import '../../../../Core/Provider/themeProvider.dart';

class EventMapCard extends StatelessWidget {
  final EventModel event;
  final Function resetPosition;
  const EventMapCard({super.key, required this.event,required this.resetPosition});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    bool isLightMode = (themeProvider.themeMode == ThemeMode.light);
    return GestureDetector(
      onTap: (){resetPosition();},
      onDoubleTap: (){Navigator.pushNamed(context, Routes.eventDetailsScreenRouteName,arguments: event);},
      child: Container(

        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: MainColors.getMainColor()),
        ),
        child: Row(
          children: [
            Image(image: AssetImage(AppImages.returnEventImage(event.eventCategory))),
            SizedBox(width: 10.w),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 140.w,
                  child: Text(
                    event.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.labelLarge(color: MainColors.getMainColor())
                  ),
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 16,
                      color: isLightMode
                          ? MainColors.getDarkColor()
                          : MainColors.getLightColor(),
                    ),
                    SizedBox(width: 4),
                    SizedBox(
                      width: 120,
                      child: Text(
                        event.location,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.bodyMedium(color: (isLightMode) ? MainColors.getDarkColor() : MainColors.getLightColor())
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
