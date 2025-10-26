import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:evently/Core/Color/light_colors.dart';
import 'package:evently/Core/Color/main_colors.dart';
import 'package:evently/Core/routes/routes.dart';
import 'package:evently/Firebase/firebase_manager.dart';
import 'package:evently/Screens/Edit%20event%20Screen/edit_event.dart';
import 'package:evently/Screens/Home%20Screen/Components/event_card.dart';

import '../../../Core/assets/const data.dart';
import '../../../Models/event_model.dart';

class HomeTab extends StatefulWidget {
  String category;
  HomeTab({super.key,required this.category});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int currTab=0;
  int selectedEvent = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: MainColors.getMainColor(),
        centerTitle: false,
        titleSpacing: 16,
        toolbarHeight: 175.h,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(24.r),
            bottomRight: Radius.circular(24.r)
          )
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      "Welcome Back ✨",
                      style: GoogleFonts.inter(
                        color: Color(0XFFF2FEFF),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        height: 1,
                        letterSpacing: 0,
                      ),
                    ),
                    Text(
                      "Username",
                      style: GoogleFonts.inter(
                        color: Color(0XFFF2FEFF),
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                        height: 1,
                        letterSpacing: 0,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.sunny,color: Color(0XFFF2FEFF),),
                    SizedBox(width: 3.w,),
                    GestureDetector(
                      onTap: (){
                        if(context.locale.toString()=='ar'){
                          context.setLocale(Locale('en'));
                          setState(() {});
                        }
                        else if(context.locale.toString()=='en'){
                          context.setLocale(Locale('ar'));
                          setState(() {});
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadiusGeometry.circular(8.r),
                          color: Color(0XFFF2FEFF),
                        ),
                        child: Text(
                          (context.locale.toString()=='en') ? "EN" : "AR",
                          style: GoogleFonts.inter(
                              color: MainColors.getMainColor(),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              height: 1,
                              letterSpacing: 0
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),

            SizedBox(height: 8.h,),
            //Location
            Row(
              children: [
                Icon(Icons.location_on_outlined,color: Color(0XFFF2FEFF),),
                SizedBox(width: 3.w,),
                Text(
                  "Location",
                  style: GoogleFonts.inter(
                    color: Color(0XFFF2FEFF),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    height: 1,
                    letterSpacing: 0,
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: SizedBox(
                height: 50.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: AppData.event.length,
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
                                ? const Color(0XFFF2FEFF)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(37.r),
                            border: Border.all(
                              color: const Color(0XFFF2FEFF),
                              width: 1,
                              style: (selectedEvent == i)
                                  ? BorderStyle.none
                                  : BorderStyle.solid,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                AppData.eventIcon[i],
                                color: (selectedEvent == i)
                                    ? MainColors.getMainColor()
                                    : const Color(0XFFF2FEFF),
                                size: 24,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                AppData.event[i],
                                style: GoogleFonts.inter(
                                  color: (selectedEvent == i)
                                      ? MainColors.getMainColor()
                                      : const Color(0XFFF2FEFF),
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
          ],
        ),
      ),
      body: StreamBuilder<QuerySnapshot<EventModel>>(
        stream: (widget.category=="All") ? FirebaseManager.getEvents() : FirebaseManager.filterEvents(widget.category),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: MainColors.getMainColor(),
              ),
            );
          }
          else if(snapshot.hasError){
            return Center(
              child: Text(
                  "Something Went Wrong!!!",
                style: GoogleFonts.inter(
                    color: MainColors.getMainColor(),
                    fontSize: 30.sp,
                    fontWeight: FontWeight.w700,
                    height: 1,
                    letterSpacing:0
                ),
              ),
            );
          }
          else if(!snapshot.hasData){
            return Center(
              child: Text(
                "No tasks yet",
                style: GoogleFonts.inter(
                    color: MainColors.getMainColor(),
                    fontSize: 30.sp,
                    fontWeight: FontWeight.w700,
                    height: 1,
                    letterSpacing:0
                ),
              ),
            );
          }
          return GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, Routes.editEventScreenRouteName,arguments: snapshot.data.doc.data());
              },
              child: EventCard(snapshot: snapshot)
          );
        },
      ),
    );
  }
  
}
