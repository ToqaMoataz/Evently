import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:evently/Core/Color/main_colors.dart';

import '../../Models/event_model.dart';
import '../../firebase/firebase_manager.dart';

class EditEventScreen extends StatefulWidget {
  const EditEventScreen({super.key});

  @override
  State<EditEventScreen> createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  late DateTime eventDate;
  late int selectedCategoryIndex;
  late EventModel event;
  bool eventChanged = false;


  List<String> categories = [
    "meeting",
    "holiday",
    "workshop",
    "sport",
    "book_club",
    "eating",
    "birthday",
    "gaming",
    "exhibition",
  ];

  final List<IconData> eventIcon = [
    Icons.groups_outlined,
    Icons.beach_access_outlined,
    Icons.work_outline,
    Icons.directions_bike_outlined,
    Icons.menu_book_outlined,
    Icons.restaurant_outlined,
    Icons.cake_outlined,
    Icons.sports_esports_outlined,
    Icons.museum_outlined,
  ];

  late TextEditingController title;
  late TextEditingController description;

  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_isInitialized) {
      event = ModalRoute.of(context)?.settings.arguments as EventModel;

      title = TextEditingController(text: event.title);
      description = TextEditingController(text: event.description);

      eventDate = DateTime.fromMillisecondsSinceEpoch(event.date);
      selectedCategoryIndex = categories.indexOf(event.eventCategory);

      _isInitialized = true;
    }
  }

  @override
  void dispose() {
    title.dispose();
    description.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: MainColors.getMainColor()),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          event.title,
          style: GoogleFonts.inter(
            fontSize: 30.sp,
            fontWeight: FontWeight.w800,
            color:MainColors.getMainColor(),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.asset(
                  "assets/images/${categories[selectedCategoryIndex]}.png",
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: SizedBox(
                  height: 50.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, i) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedCategoryIndex = i;
                            });
                          },
                          child: Container(
                            height: 40.h,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              color: (selectedCategoryIndex == i)
                                  ? const Color(0XFF5669FF)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(37.r),
                              border: Border.all(
                                color: (categories[i]==event.eventCategory) ? Colors.black : Color(0XFF5669FF),
                                width: 1,
                                style: (selectedCategoryIndex == i)
                                    ? BorderStyle.none
                                    : BorderStyle.solid,
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  eventIcon[i],
                                  color: (selectedCategoryIndex == i)
                                      ? Colors.white
                                      : const Color(0XFF5669FF),
                                  size: 24,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  categories[i],
                                  style: GoogleFonts.inter(
                                    color: (selectedCategoryIndex == i)
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
              ),
              // Event title
              Text(
                "Title:",
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: MainColors.getMainColor(),
                ),
              ),
              TextField(
                onChanged: (value){
                  eventChanged=true;
                },
                controller: title,
                decoration: InputDecoration(
                  hintText: event.title,
                  hintStyle: GoogleFonts.inter(
                    color: const Color(0XFF7B7B7B),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0XFF7B7B7B), width: 1),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0XFF5669FF), width: 1),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                ),
              ),
          
              SizedBox(height: 16),
              // Event description
              Text(
                "Description:",
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: MainColors.getMainColor(),
                ),
              ),
              TextField(
                onChanged: (value){
                  eventChanged=true;
                },
                controller: description,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: event.description,
                  hintStyle: GoogleFonts.inter(
                    color: const Color(0XFF7B7B7B),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0XFF7B7B7B), width: 1),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0XFF5669FF), width: 1),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Event Date",
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  GestureDetector(
                    onTap: () {
                      selectTaskDate();
                    },
                    child: Text(
                      eventDate.toString().substring(0, 10),
                      style: TextStyle(fontSize: 18, color: Colors.blue),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              //edit button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 50.h,
                    width: MediaQuery.of(context).size.width/2.w,
                    child: ElevatedButton(
                      onPressed: () {
                        if(eventChanged){
                          //print("changeddddddddddd");
                          EventModel model = EventModel(
                            title: title.text,
                            userId: FirebaseAuth.instance.currentUser!.uid,
                            description: description.text,
                            eventCategory: categories[selectedCategoryIndex],
                            date: eventDate.millisecondsSinceEpoch,
                            id: event.id,
                            time: '',
                            location: '',
                          );
                          FirebaseManager.editEvent(model).then((_) {
                            Navigator.pop(context);
                          });
                        }
                        else{
                          //print("neverrrrrrrrrrrrrrr");
                          Navigator.pop(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                      child: Text(
                        "Edit Event",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      FirebaseManager.deleteEvent(event.id).then((onValue){
                        Navigator.pop(context);
                      });
                    },
                    child: Container(
                      height: 50.h,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadiusGeometry.circular(16.r),
                        color: Colors.red
                      ),
                      child: Icon(Icons.delete_outline,color: Colors.white,),
                    ),
                  )
          
                ],
              ),
          
            ],
          ),
        ),
      ),
    );
  }
  selectTaskDate() async {
    DateTime? chosenDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );

    if (chosenDate != null) {
      eventChanged=true;
      eventDate = chosenDate;
    }
    setState(() {});
  }


}
