import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Core/Color/main_colors.dart';
import '../../Edit event Screen/edit_event.dart';

class EventCard extends StatelessWidget {
  AsyncSnapshot<dynamic> snapshot;
  EventCard({super.key,required this.snapshot});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 16,
        right: 16,
        left: 16,
      ),
      child: ListView.separated(
        itemCount: snapshot.data.docs.length ?? 0,
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 16.h,
          );
        },
        itemBuilder: (context,index){
          //Date
          String formattedDate = formatDateFromMillis(snapshot.data!.docs[index].data().date);
          String day = DateFormat('d').format(DateTime.fromMillisecondsSinceEpoch(snapshot.data!.docs[index].data().date));
          String month = DateFormat('MMM').format(DateTime.fromMillisecondsSinceEpoch(snapshot.data!.docs[index].data().date));
          return Container(
            height: 200.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r)
            ),
            child: Stack(
              children: [
                ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(16.r),
                    child: Image(image: AssetImage("assets/images/${snapshot.data.docs[index].data().eventCategory}.png"))
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0,left: 8),
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Color(0XFFF2FEFF),
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
                            color: Color(0XFFF2FEFF),
                            borderRadius: BorderRadius.circular(8.r)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              snapshot.data.docs[index].data().title ?? "Title",
                              style: GoogleFonts.inter(
                                  color: Color(0XFF1C1C1C),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                  height: 1,
                                  letterSpacing:0
                              ),
                            ),
                            IconButton(
                              onPressed: (){

                              },
                              icon:Icon(
                                  Icons.favorite_border,
                                  color:MainColors.getMainColor()
                              ),
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
          );
        },
      ),
    );
  }
  String formatDateFromMillis(int millis) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(millis);
    return DateFormat('d MMMM yyyy').format(date);
  }
}
