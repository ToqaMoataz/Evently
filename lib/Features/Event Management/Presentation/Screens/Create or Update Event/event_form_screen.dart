
import 'package:easy_localization/easy_localization.dart';
import 'package:evently/Core/assets/const%20data.dart';
import 'package:evently/Core/assets/images.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../../Core/App Colors/main_colors.dart';
import '../../../../../Core/App Routing/routes.dart';
import '../../../../../Core/App Text Styles/app_textstyles.dart';
import '../../../../../Core/Models/event_model.dart';
import '../../../../../Core/Provider/themeProvider.dart';
import '../../Cubit/States/event_form_states.dart';
import '../../Cubit/View Models/event_form_view_model.dart';

class EventFormScreen extends StatefulWidget {
  const EventFormScreen({super.key});

  @override
  State<EventFormScreen> createState() => _EventFormScreenState();
}

class _EventFormScreenState extends State<EventFormScreen> {
  late EventFormViewModel viewModel;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  EventModel? event;



  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    viewModel = context.read<EventFormViewModel>();

    event = ModalRoute.of(context)?.settings.arguments as EventModel?;
    if (event != null) {
      titleController.text=event!.title;
      descriptionController.text=event!.description;
      viewModel.loadEvent(event!);
    }
  }


  @override
  void dispose() {
    viewModel.resetState();
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider=Provider.of<ThemeProvider>(context);
    Color color =
        (Theme.of(context).brightness == Brightness.dark)
            ? MainColors.getLightColor()
            : MainColors.getDarkColor();

    bool isDark =
        (Theme.of(context).brightness == Brightness.dark) ? true : false;
    return Scaffold(
      appBar: AppBar(
        title: Text((event == null) ? "create_event_text".tr() : "edit_event_text".tr()),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocConsumer<EventFormViewModel, EventFormState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16.h),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child: Image.asset(
                      (event == null)
                          ? AppImages.returnEventImage(AppData.events[state.selectedEvent])
                          :AppImages.returnEventImage(event!.eventCategory),
                      height: 200.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  SizedBox(
                    height: 50.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: AppData.events.length,
                      itemBuilder: (context, i) {
                        if (i == 0) return const SizedBox.shrink();
                        return Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: GestureDetector(
                            onTap: () {
                              viewModel.selectEventCategory(i);
                            },
                            child: Container(
                              height: 40.h,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    (state.selectedEvent == i)
                                        ? MainColors.getMainColor()
                                        : Colors.transparent,
                                borderRadius: BorderRadius.circular(37.r),
                                border: Border.all(
                                  color: MainColors.getMainColor(),
                                  style:
                                      (state.selectedEvent == i)
                                          ? BorderStyle.none
                                          : BorderStyle.solid,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    AppData.eventIcon[i],
                                    color:
                                        (state.selectedEvent == i)
                                            ? Colors.white
                                            : MainColors.getMainColor(),
                                    size: 24,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    AppData.eventsDisplay[i].tr(),
                                    style: GoogleFonts.inter(
                                      color:
                                          (state.selectedEvent == i)
                                              ? Colors.white
                                              : MainColors.getMainColor(),
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 16.h),
                  // Event Title
                  Text(
                      "title_text".tr(),
                    style: AppTextStyles.titleMedium(color: color)
                  ),
                  TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(
                      hintText: "title_text".tr(),
                      hintStyle: AppTextStyles.hintTextStyle(themeMode: themeProvider.themeMode),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18.r),
                        borderSide: BorderSide(
                          color: MainColors.getGreyColor(),
                          width: 1.5,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18.r),
                        borderSide: BorderSide(
                          color: MainColors.getGreyColor(),
                          width: 1,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18.r),
                        borderSide: BorderSide(
                          color: MainColors.getRedColor(),
                          width: 1,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18.r),
                        borderSide: BorderSide(
                          color: MainColors.getRedColor(),
                          width: 1.5,
                        ),
                      ),
                      prefixIcon: Icon(
                        Icons.edit_note_outlined,
                        color:
                            (!isDark) ? MainColors.getGreyColor() : color,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // Description
                  Text(
                      "description_text".tr(),
                    style: AppTextStyles.titleMedium(color: color)
                  ),
                  SizedBox(height: 8.h),
                  TextFormField(
                    controller: descriptionController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText:"event_description_text".tr(),
                      hintStyle: AppTextStyles.hintTextStyle(themeMode: themeProvider.themeMode),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18.r),
                        borderSide: BorderSide(
                          color: MainColors.getGreyColor(),
                          width: 1.5,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18.r),
                        borderSide: BorderSide(
                          color: MainColors.getGreyColor(),
                          width: 1,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18.r),
                        borderSide: BorderSide(
                          color: MainColors.getRedColor(),
                          width: 1,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18.r),
                        borderSide: BorderSide(
                          color: MainColors.getRedColor(),
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 16.h),

                  // Event Date
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_month_outlined,
                        color: MainColors.getMainColor(),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                          "event_date_text".tr(),
                        style: AppTextStyles.titleMedium(color: color)
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () async {
                          var date = await selectDate();
                          if (date != null) {
                            viewModel.setEventDate(date);
                          }
                        },
                        child: Text(
                           (state.eventDate != null)
                              ? state.eventDate.toString().substring(0, 10)
                              : "choose_date_text".tr(),
                          style: AppTextStyles.titleMedium(color: MainColors.getMainColor())
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),

                  // Event Time
                  Row(
                    children: [
                      Icon(
                        Icons.access_time_outlined,
                        color: MainColors.getMainColor(),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                          "event_time_text".tr(),
                        style: AppTextStyles.titleMedium(color: color)
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () async {
                          String? time = await pickTime();
                          if (time != null && mounted) {
                            viewModel.setEventTime(time);
                          }
                        },

                        child: Text(
                           (state.eventTime==null)
                              ? "choose_time_text".tr()
                              : state.eventTime!,
                          style: AppTextStyles.titleMedium(color: MainColors.getMainColor())
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),

                  // Location
                  Text(
                    "location_label_text".tr(),
                    style: AppTextStyles.titleMedium(color:color),
                  ),
                  SizedBox(height: 8.h),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        Routes.mapScreenRouteName,
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: MainColors.getMainColor()),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: MainColors.getMainColor(),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Icon(
                              Icons.my_location,
                              color:
                                  Theme.of(context).scaffoldBackgroundColor,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Text(
                             ((state.currentLocation == null)
                                    ? "choose_event_location_text".tr()
                                    : state.currentLocation!)
                              ,
                            style: AppTextStyles.titleMedium(color: color)
                          ),
                          Spacer(),
                          Icon(
                            Icons.chevron_right,
                            color: MainColors.getMainColor(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),

                  // Event Button
                  SizedBox(
                    width: double.infinity,
                    height: 50.h,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MainColors.getMainColor(),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      // Save Event
                      onPressed: () {
                        if (validateForm(state)) {
                          EventModel newEvent = EventModel(
                            eventCategory: AppData.events[state.selectedEvent],
                            title: titleController.text.trim(),
                            description: descriptionController.text.trim(),
                            date: state.eventDate!.millisecondsSinceEpoch,
                            time: state.eventTime!,
                            location: state.currentLocation!,
                            userId: FirebaseAuth.instance.currentUser!.uid,
                            eventPosition: state.currentPosition!
                          );
                          viewModel.saveEvent(newEvent, event);
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("incomplete_info_title".tr()),
                                content: Text("complete_event_info_message".tr()),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("ok_text".tr()),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },

                      child: Text(
                        (event==null) ? "add_event_text".tr() : "update_event_text".tr(),
                        style: AppTextStyles.buttonTextStyle(),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                ],
              ),
            );
          },
          listener: (context, state) {
            if (state.createEventRequestState == RequestState.success || state.updateEventRequestState==RequestState.success) {
              Navigator.pushReplacementNamed(context, Routes.homeScreenRouteName);
            }
          },
        ),
      ),
    );
  }

  Future<DateTime?> selectDate() async {
    DateTime? chosenDate = await showDatePicker(
      builder: (context, child) {
        return Theme(
          data: ThemeData(
            colorScheme: ColorScheme.light(
              primary: MainColors.getMainColor(),
              onPrimary: Colors.white,
              onSurface: MainColors.getMainColor(),
            ),
          ),
          child: child!,
        );
      },
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 366)),
    );
    return chosenDate;

  }

  Future<String?> pickTime() async {
    final TimeOfDay? chosenTime = await showTimePicker(
      builder: (context, child) {
        return Theme(
          data: ThemeData(
            colorScheme: ColorScheme.light(
              primary: MainColors.getMainColor(),
              onPrimary: Colors.white,
              onSurface: MainColors.getMainColor(),
            ),
          ),
          child: child!,
        );
      },
      context: context,
      initialTime: TimeOfDay.now(),
    );
    return chosenTime?.format(context);
  }

  bool validateForm(EventFormState state) {
    if (titleController.text.trim().isEmpty) {
      print("Validation failed: title is empty");
      return false;
    }
    if (descriptionController.text.trim().isEmpty) {
      print("Validation failed: description is empty");
      return false;
    }
    if (state.eventDate == null) {
      print("Validation failed: eventDate is null");
      return false;
    }
    if (state.eventTime == null) {
      print("Validation failed: eventTime is null");
      return false;
    }
    if (state.currentLocation == null) {
      print("Validation failed: currentLocation is null");
      return false;
    }
    print("Validation passed: all fields are filled");
    return true;
  }


}
