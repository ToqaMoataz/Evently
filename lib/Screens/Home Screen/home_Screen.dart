import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:evently/Core/Color/main_colors.dart';
import 'package:evently/Provider/themeProvider.dart';
import 'package:evently/Screens/Home%20Screen/Tabs/fav_tab.dart';
import 'package:evently/Screens/Home%20Screen/Tabs/home_tab.dart';
import 'package:evently/Screens/Home%20Screen/Tabs/map_tab.dart';
import 'package:evently/Screens/Create%20Event%20Screen/create_event.dart';

import '../../Core/assets/const data.dart';
import '../../Core/routes/routes.dart';
import '../../Provider/themeProvider.dart';
import 'Tabs/profile_tab.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName="/home";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int currTab=0;
  int selectedEvent = 0;

  late ThemeProvider themeProvider;
  @override
  void initState(){
    super.initState();
    themeProvider=Provider.of<ThemeProvider>(context);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   backgroundColor: MainColors.getMainColor(),
      //   centerTitle: false,
      //   titleSpacing: 16,
      //   toolbarHeight: 175.h,
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.only(
      //       bottomLeft: Radius.circular(24.r),
      //       bottomRight: Radius.circular(24.r)
      //     )
      //   ),
      //   title: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         children: [
      //           Column(
      //             children: [
      //               Text(
      //                 "Welcome Back ✨",
      //                 style: GoogleFonts.inter(
      //                   color: Color(0XFFF2FEFF),
      //                   fontSize: 14.sp,
      //                   fontWeight: FontWeight.w400,
      //                   height: 1,
      //                   letterSpacing: 0,
      //                 ),
      //               ),
      //               Text(
      //                 "Username",
      //                 style: GoogleFonts.inter(
      //                   color: Color(0XFFF2FEFF),
      //                   fontSize: 24.sp,
      //                   fontWeight: FontWeight.w700,
      //                   height: 1,
      //                   letterSpacing: 0,
      //                 ),
      //               ),
      //             ],
      //           ),
      //           Row(
      //             children: [
      //               Icon(Icons.sunny,color: Color(0XFFF2FEFF),),
      //               SizedBox(width: 3.w,),
      //               GestureDetector(
      //                 onTap: (){
      //                   if(context.locale.toString()=='ar'){
      //                     context.setLocale(Locale('en'));
      //                     setState(() {});
      //                   }
      //                   else if(context.locale.toString()=='en'){
      //                     context.setLocale(Locale('ar'));
      //                     setState(() {});
      //                   }
      //                 },
      //                 child: Container(
      //                   padding: EdgeInsets.all(8),
      //                   decoration: BoxDecoration(
      //                     borderRadius: BorderRadiusGeometry.circular(8.r),
      //                     color: Color(0XFFF2FEFF),
      //                   ),
      //                   child: Text(
      //                     (context.locale.toString()=='en') ? "EN" : "AR",
      //                     style: GoogleFonts.inter(
      //                         color: MainColors.getMainColor(),
      //                         fontSize: 14.sp,
      //                         fontWeight: FontWeight.w700,
      //                         height: 1,
      //                         letterSpacing: 0
      //                     ),
      //                   ),
      //                 ),
      //               )
      //             ],
      //           )
      //         ],
      //       ),
      //
      //       SizedBox(height: 8.h,),
      //       //Location
      //       Row(
      //         children: [
      //           Icon(Icons.location_on_outlined,color: Color(0XFFF2FEFF),),
      //           SizedBox(width: 3.w,),
      //           Text(
      //             "Location",
      //             style: GoogleFonts.inter(
      //               color: Color(0XFFF2FEFF),
      //               fontSize: 14.sp,
      //               fontWeight: FontWeight.w500,
      //               height: 1,
      //               letterSpacing: 0,
      //             ),
      //           )
      //         ],
      //       ),
      //       Padding(
      //         padding: const EdgeInsets.symmetric(vertical: 16),
      //         child: SizedBox(
      //           height: 50.h,
      //           child: ListView.builder(
      //             scrollDirection: Axis.horizontal,
      //             itemCount: event.length,
      //             itemBuilder: (context, i) {
      //               return Padding(
      //                 padding: const EdgeInsets.only(right: 10),
      //                 child: GestureDetector(
      //                   onTap: () {
      //                     setState(() {
      //                       selectedEvent = i;
      //                     });
      //                   },
      //                   child: Container(
      //                     height: 40.h,
      //                     padding: const EdgeInsets.symmetric(
      //                         horizontal: 16, vertical: 12),
      //                     decoration: BoxDecoration(
      //                       color: (selectedEvent == i)
      //                           ? const Color(0XFFF2FEFF)
      //                           : Colors.transparent,
      //                       borderRadius: BorderRadius.circular(37.r),
      //                       border: Border.all(
      //                         color: const Color(0XFFF2FEFF),
      //                         width: 1,
      //                         style: (selectedEvent == i)
      //                             ? BorderStyle.none
      //                             : BorderStyle.solid,
      //                       ),
      //                     ),
      //                     child: Row(
      //                       children: [
      //                         Icon(
      //                           eventIcon[i],
      //                           color: (selectedEvent == i)
      //                               ? MainColors.getMainColor()
      //                               : const Color(0XFFF2FEFF),
      //                           size: 24,
      //                         ),
      //                         const SizedBox(width: 8),
      //                         Text(
      //                           event[i],
      //                           style: GoogleFonts.inter(
      //                             color: (selectedEvent == i)
      //                                 ? MainColors.getMainColor()
      //                                 : const Color(0XFFF2FEFF),
      //                             fontSize: 16,
      //                             fontWeight: FontWeight.w700,
      //                           ),
      //                         ),
      //                       ],
      //                     ),
      //                   ),
      //                 ),
      //               );
      //             },
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
            Navigator.pushNamed(context, Routes.createEventScreenRouteName);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(75.r),
          side: BorderSide(
            color:Color(0XFFF2FEFF),
            width: 5,
          )
        ),
        child: Icon(Icons.add,color:Color(0XFFF2FEFF),size: 30,),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currTab,
        onTap: (value){
          currTab=value;
          setState(() {});
        },
          selectedLabelStyle: GoogleFonts.inter(
            color: Color(0XFFF2FEFF),
            fontSize: 12.sp,
            fontWeight: FontWeight.w700,
            height: 1,
            letterSpacing: 0,
          ),
          type: BottomNavigationBarType.fixed,
          unselectedItemColor:Color(0XFF5669FF) ,
          selectedItemColor:Color(0XFFF2FEFF),
          iconSize: 24,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          items: [
        BottomNavigationBarItem(icon: Icon(Icons.home_filled,color: Color(0XFFF2FEFF)),label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.location_on_outlined,color: Color(0XFFF2FEFF)),label: "Map"),
        BottomNavigationBarItem(icon: Icon(Icons.favorite_border,color: Color(0XFFF2FEFF)),label: "Love"),
        BottomNavigationBarItem(icon: Icon(Icons.person,color: Color(0XFFF2FEFF)),label: "Profile"),
      ]),
      body: returnTab()
    );
  }
  Widget returnTab(){
    if(currTab==0){
      return HomeTab(category: AppData.event[selectedEvent]);
    }
    else if(currTab==1){
      return MapTab();
    }
    else if(currTab==2){
      return FavTab(themeProvider);
    }
    return ProfileTab();
  }
}
