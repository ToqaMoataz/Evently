import 'package:evently/Features/Authentication%20Screens/Presentation/Components/text_field_card.dart';
import 'package:evently/Core/Color/main_colors.dart';
import 'package:evently/Core/Dependency%20Injection/di.dart';
import 'package:evently/Core/Text%20Styles/app_textstyles.dart';
import 'package:evently/Core/assets/const%20data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../../Core/Models/event_model.dart';

import '../../../../../Core/routes/routes.dart';
import '../../Cubit/States/event_creation_states.dart';
import '../../Cubit/View Models/event_creation_view_model.dart';

class EventFormScreen extends StatefulWidget {
  const EventFormScreen({super.key});

  @override
  State<EventFormScreen> createState() => _EventFormScreenState();
}

class _EventFormScreenState extends State<EventFormScreen> {
  late EventCreationViewModel viewModel;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  EventModel? event;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    event = ModalRoute.of(context)!.settings.arguments as EventModel?;
    if (event != null) {
      viewModel.setIndexWithCategory(event!.eventCategory);
    }
  }

  @override
  void initState() {
    super.initState();
    viewModel = getIt<EventCreationViewModel>();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color textColor =
        (Theme.of(context).brightness == Brightness.dark)
            ? MainColors.getLightColor()
            : MainColors.getTDarkColor();

    bool isDark =
        (Theme.of(context).brightness == Brightness.dark) ? true : false;
    return Scaffold(
      appBar: AppBar(
        title: Text((event == null) ? "Create Event" : "Edit Event"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocProvider(
          create: (context) => viewModel,
          child: BlocConsumer<EventCreationViewModel, EventCreationState>(
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
                            ? "assets/images/${AppData.events[state.selectedEvent]}.png"
                            : "assets/images/${event?.eventCategory}.png",
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
                                      AppData.events[i],
                                      style: GoogleFonts.inter(
                                        color:
                                            (state.selectedEvent == i)
                                                ? Colors.white
                                                : MainColors.getMainColor(),
                                        fontSize: 16,
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
                      "Title",
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: textColor,
                      ),
                    ),
                    TextFormField(
                      controller: titleController,
                      decoration: InputDecoration(
                        hintText: (event != null) ? event!.title : "Title",
                        hintStyle: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color:
                              (!isDark) ? MainColors.getGrayColor() : textColor,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18.r),
                          borderSide: BorderSide(
                            color: MainColors.getGrayColor(),
                            width: 1.5,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18.r),
                          borderSide: BorderSide(
                            color: MainColors.getGrayColor(),
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
                              (!isDark) ? MainColors.getGrayColor() : textColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Description
                    Text(
                      "Description",
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: textColor,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    TextFormField(
                      controller: descriptionController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText:
                            (event != null)
                                ? event!.description
                                : "Event Description",
                        hintStyle: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color:
                              (!isDark) ? MainColors.getGrayColor() : textColor,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18.r),
                          borderSide: BorderSide(
                            color: MainColors.getGrayColor(),
                            width: 1.5,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18.r),
                          borderSide: BorderSide(
                            color: MainColors.getGrayColor(),
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
                          "Event Date",
                          style: AppTextStyles.simpleHeadLineTextStyle(
                            textColor,
                          ),
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
                                : "Choose Date",
                            style: GoogleFonts.inter(
                              color: MainColors.getMainColor(),
                              fontWeight: FontWeight.w600,
                              fontSize: 16.sp,
                            ),
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
                          color: const Color(0XFF5669FF),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          "Event Time",
                          style: AppTextStyles.simpleHeadLineTextStyle(
                            textColor,
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () async {
                            TimeOfDay? time=await pickTime();
                            if(time!=null){
                              viewModel.setEventTime(time);
                            }
                          },
                          child: Text(
                            (state.eventTime==null)?
                            "Choose Time" : state.eventTime!.format(context),
                            style: GoogleFonts.inter(
                              color: MainColors.getMainColor(),
                              fontWeight: FontWeight.w600,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),

                    // Location
                    Text(
                      "Location",
                      style: AppTextStyles.simpleHeadLineTextStyle(textColor),
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
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                Icons.my_location,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Text(
                              (event == null)
                                  ? ((state.currentLocation == null)
                                      ? "Choose Event Location"
                                      : state.currentLocation!)
                                  : event!.location,
                              style: AppTextStyles.simpleHeadLineTextStyle(
                                textColor,
                              ),
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

                    // Add Event Button
                    SizedBox(
                      width: double.infinity,
                      height: 50.h,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0XFF5669FF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        //Logic is hereee
                        onPressed: () {
                          EventModel newEvent = EventModel(
                            eventCategory: AppData.events[state.selectedEvent],
                            title: titleController.text,
                            description: descriptionController.text,
                            date: state.eventDate!.millisecondsSinceEpoch,
                            time: state.eventTime!.format(context),
                            location: state.currentLocation ?? "location",
                            userId: FirebaseAuth.instance.currentUser!.uid,
                            eventPosition:
                                state.currentPosition ??
                                LatLng(30.03164525, 31.21078347),
                          );
                          viewModel.createEvent(newEvent);
                        },
                        child: Text(
                          "Add Event",
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
              if (state.createEventRequestState == RequestState.success) {
                Navigator.pop(context);
              }
            },
          ),
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
              primary: Color(0XFF5669FF),
              onPrimary: Colors.white,
              onSurface: Color(0XFF5669FF),
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

    if (chosenDate != null) {
      return chosenDate;
    }
    return null;
  }

  Future<TimeOfDay?> pickTime() async {
    final TimeOfDay? chosenTime = await showTimePicker(
      builder: (context, child) {
        return Theme(
          data: ThemeData(
            colorScheme: ColorScheme.light(
              primary: Color(0XFF5669FF),
              onPrimary: Colors.white,
              onSurface: Color(0XFF5669FF),
            ),
          ),
          child: child!,
        );
      },
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (chosenTime != null) {
      return chosenTime;
    }
    return null;
  }
}
