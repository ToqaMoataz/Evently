import 'package:easy_localization/easy_localization.dart';
import 'package:evently/Core/App%20Widgets/network_snackbar.dart';
import 'package:evently/Core/Dependency%20Injection/di.dart';
import 'package:evently/Core/Models/event_model.dart';
import 'package:evently/Core/Provider/themeProvider.dart';
import 'package:evently/Core/assets/const%20data.dart';
import 'package:evently/Core/assets/images.dart';
import 'package:evently/Features/Event%20Management/Presentation/Cubit/States/event_form_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../../Core/App Colors/main_colors.dart';
import '../../../../../Core/App Routing/routes.dart';
import '../../../../../Core/App Text Styles/app_textstyles.dart';
import '../../../../../Core/Provider/network_info_provider.dart';
import '../../Cubit/View Model/event_form_view_model.dart';

class EventDetailsScreen extends StatelessWidget {
  EventDetailsScreen({super.key});

  final EventFormViewModel viewModel = getIt<EventFormViewModel>();

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    var networkProvider=Provider.of<NetworkProvider>(context);
    var event = ModalRoute.of(context)?.settings.arguments as EventModel;
    return BlocProvider(
      create: (context) => viewModel,
      child: BlocListener<EventFormViewModel, EventFormState>(
        listener: (BuildContext context, state) {
          if (state.deleteEventRequestState == RequestState.success) {
            Navigator.pop(context);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    Routes.formEventScreenRouteName,
                    arguments: event,
                  );
                },
                icon: Icon(
                  Icons.edit_outlined,
                  color: MainColors.getMainColor(),
                ),
              ),
              IconButton(
                onPressed: () {
                  if(networkProvider.isOnline){
                    showDeleteEventDialog(context, () {
                      viewModel.deleteEvent(event.id);
                    });
                  }
                  else{
                    NetworkSnackBar.show(context, false);
                  }
                },
                icon: Icon(
                  Icons.delete_outline,
                  color: MainColors.getRedColor(),
                ),
              ),
            ],
            title: Text("event_details_text".tr()),
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 20,left: 20,right: 20,bottom: 8),
            child: SingleChildScrollView(
              child: Column(
                spacing: 16.h,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child: Image(
                      image: AssetImage(
                        AppImages.returnEventImage(event.eventCategory),
                      ),
                      height: 205.h,
                    ),
                  ),
                  Text(
                    event.title,
                    style: GoogleFonts.inter(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w500,
                      color: MainColors.getMainColor(),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: MainColors.getMainColor()),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 48.w,
                          height: 48.h,
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: MainColors.getMainColor(),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Icon(
                            Icons.date_range_outlined,
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                            DateTime.fromMillisecondsSinceEpoch(event.date).toString().substring(0, 10),
                              style: AppTextStyles.titleMedium(
                                color: MainColors.getMainColor(),
                              ),
                            ),
                            Text(
                              event.time,
                              style: AppTextStyles.titleMedium(
                                color:
                                    (themeProvider.themeMode == ThemeMode.light)
                                        ? MainColors.getDarkColor()
                                        : MainColors.getLightColor(),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: MainColors.getMainColor()),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 48.w,
                          height: 48.h,
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: MainColors.getMainColor(),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Icon(
                            Icons.location_searching_sharp,
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Flexible(
                          child: Text(
                            event.location,
                            style: AppTextStyles.titleMedium(
                              color: MainColors.getMainColor(),
                            ),
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            color: MainColors.getMainColor(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //Map part
                  Container(
                    height: 361.h,
                    decoration: BoxDecoration(
                      border: Border.all(color: MainColors.getMainColor()),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: event.eventPosition,
                        zoom: 18
                      ),
                      zoomGesturesEnabled: true,
                      scrollGesturesEnabled: false,
                      markers: {Marker(markerId: MarkerId("event"),position: event.eventPosition,icon:BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue))},
                    ),
                  ),

                  //Description
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "description_text".tr(),
                        style: AppTextStyles.titleMedium(
                          color:
                              (themeProvider.themeMode == ThemeMode.light)
                                  ? MainColors.getDarkColor()
                                  : MainColors.getLightColor(),
                        ),
                      ),
                      SizedBox(height: 8.h,),
                      Text(
                        event.description,
                        style: AppTextStyles.bodySmall(
                          color:
                          (themeProvider.themeMode == ThemeMode.light)
                              ? MainColors.getDarkColor()
                              : MainColors.getLightColor(),
                        ),
                      ),
                      SizedBox(height: 24.h),
                      Row(
                        children: [
                          Icon(
                            (event.toBeNotified)
                                ? Icons.notifications_on_outlined
                                : Icons.notifications_off_outlined,
                            color: MainColors.getMainColor(),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            "notification_text".tr(),
                            style: AppTextStyles.titleMedium(color: (Theme.of(context).brightness == Brightness.dark)
                                ? MainColors.getLightColor()
                                : MainColors.getDarkColor()),
                          ),
                          Spacer(),
                          Switch(
                            hoverColor: MainColors.getLightColor(),
                            activeColor: MainColors.getMainColor(),
                            value:event.toBeNotified,
                            onChanged: null,
                          )


                        ],
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  void showDeleteEventDialog(BuildContext context, VoidCallback onDelete) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title:Text( "delete_event_text".tr(),style: AppTextStyles.titleMedium(color: MainColors.getMainColor()),),
          content: Text("delete_event_message".tr(),style: AppTextStyles.bodySmall(color: MainColors.getMainColor()),),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child:Text("cancel_text".tr(),style: GoogleFonts.inter(color: MainColors.getMainColor())),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onDelete();
              },
              child: Text("yes_delete_text".tr(),style: GoogleFonts.inter(color: MainColors.getMainColor()),),
            ),
          ],
        );
      },
    );
  }
}
