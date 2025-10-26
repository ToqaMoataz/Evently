import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:evently/Firebase/firebase_manager.dart';
import 'package:evently/Models/event_model.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  int selectedEvent = 0;

  final List<String> event = [
    "Book Club",
    "Sport",
    "Birthday",
    "Eating",
    "Meeting",
    "Workshop",
    "Holiday",
    "Gaming",
    "Exhibition"
  ];

  final List<IconData> eventIcon = [
    Icons.menu_book_outlined,
    Icons.directions_bike_outlined,
    Icons.cake_outlined,
    Icons.restaurant_outlined,
    Icons.groups_outlined,
    Icons.work_outline,
    Icons.beach_access_outlined,
    Icons.sports_esports_outlined,
    Icons.museum_outlined,
  ];

  DateTime eventDate = DateTime.now();
  bool dateIsSelected = false;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  @override
  void dispose() {
    // Always dispose controllers to prevent memory leaks
    titleController.dispose();
    descriptionController.dispose();
    locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back, color: const Color(0XFF5669FF)),
        title: Text(
          "Create Event",
          style: GoogleFonts.inter(
            color: const Color(0XFF5669FF),
            fontSize: 24.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),
              ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: Image.asset(
                  "assets/images/${event[selectedEvent]}.png",
                  height: 200.h,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 16.h),
              SizedBox(
                height: 50.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: event.length,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedEvent = i;
                          });
                        },
                        child: Container(
                          height: 40.h,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: (selectedEvent == i)
                                ? const Color(0XFF5669FF)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(37.r),
                            border: Border.all(
                              color: const Color(0XFF5669FF),
                              width: 1,
                              style: (selectedEvent == i)
                                  ? BorderStyle.none
                                  : BorderStyle.solid,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                eventIcon[i],
                                color: (selectedEvent == i)
                                    ? Colors.white
                                    : const Color(0XFF5669FF),
                                size: 24,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                event[i],
                                style: GoogleFonts.inter(
                                  color: (selectedEvent == i)
                                      ? Colors.white
                                      : const Color(0XFF5669FF),
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
                    fontSize: 16.sp, fontWeight: FontWeight.w500),
              ),
              TextFormField(
                controller: titleController, // ✅ Controller here
                decoration: InputDecoration(
                  labelText: "Title",
                  labelStyle: TextStyle(color: Color(0XFF7B7B7B)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18.r),
                    borderSide: BorderSide(color: Color(0XFF7B7B7B), width: 1.5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18.r),
                    borderSide: BorderSide(color: Color(0XFF7B7B7B), width: 1),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18.r),
                    borderSide: BorderSide(color: Colors.red, width: 1),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18.r),
                    borderSide: BorderSide(color: Colors.red, width: 1.5),
                  ),
                  prefixIcon: Icon(Icons.edit_note_outlined,
                      color: Color(0XFF7B7B7B)),
                ),
              ),
              SizedBox(height: 16.h),

              // Description
              Text(
                "Description",
                style: GoogleFonts.inter(
                    fontSize: 16.sp, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 8.h),
              TextFormField(
                controller: descriptionController, // ✅ Controller here
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: "Event Description",
                  labelStyle: TextStyle(color: Color(0XFF7B7B7B)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18.r),
                    borderSide: BorderSide(color: Color(0XFF7B7B7B), width: 1.5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18.r),
                    borderSide: BorderSide(color: Color(0XFF7B7B7B), width: 1),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18.r),
                    borderSide: BorderSide(color: Colors.red, width: 1),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18.r),
                    borderSide: BorderSide(color: Colors.red, width: 1.5),
                  ),
                ),
              ),

              SizedBox(height: 16.h),

              // Event Date
              Row(
                children: [
                  Icon(Icons.calendar_month_outlined,
                      color: const Color(0XFF5669FF)),
                  SizedBox(width: 8.w),
                  Text("Event Date",
                      style: GoogleFonts.inter(fontSize: 16.sp)),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      selectDate();
                    },
                    child: Text(
                      (dateIsSelected)
                          ? eventDate.toString().substring(0, 10)
                          : "Choose Date",
                      style: GoogleFonts.inter(
                          color: const Color(0XFF5669FF),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),

              // Event Time
              Row(
                children: [
                  Icon(Icons.access_time_outlined,
                      color: const Color(0XFF5669FF)),
                  SizedBox(width: 8.w),
                  Text("Event Time",
                      style: GoogleFonts.inter(fontSize: 16.sp)),
                  const Spacer(),
                  Text(
                    "Choose Time",
                    style: GoogleFonts.inter(
                        color: const Color(0XFF5669FF),
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(height: 16.h),

              // Location
              Text(
                "Location",
                style: GoogleFonts.inter(
                    fontSize: 16.sp, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 8.h),
              TextFormField(
                controller: locationController,
                decoration: InputDecoration(
                  hintText: "Choose Event Location",
                  labelStyle: TextStyle(color: Color(0XFF7B7B7B)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: const Color(0XFF5669FF)),
                  ),
                  prefixIcon: Icon(Icons.location_on_outlined,
                      color: Color(0XFF5669FF)),
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
                  onPressed: () {
                    EventModel newEvent=EventModel(
                        eventCategory: event[selectedEvent],
                        title:titleController.text,
                        description: descriptionController.text,
                        date: eventDate.millisecondsSinceEpoch,
                        time: "time",
                        location: "location",
                        userId: FirebaseAuth.instance.currentUser!.uid,
                    );
                    FirebaseManager.addEvent(newEvent).then((value){
                      Navigator.pop(context);
                    });

                  },
                  child: Text(
                    "Add Event",
                    style: GoogleFonts.inter(
                        color: Color(0XFFFFFFFF),
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }

  selectDate() async {
    DateTime? chosenDate = await showDatePicker(
        builder: (context, child) {
          return Theme(
              data: ThemeData(
                  colorScheme: ColorScheme.light(
                      primary: Color(0XFF5669FF),
                      onPrimary: Colors.white,
                      onSurface: Color(0XFF5669FF))),
              child: child!);
        },
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 366)));
    setState(() {
      if (chosenDate != null) {
        eventDate = chosenDate;
        dateIsSelected = true;
      }
    });
  }
}

