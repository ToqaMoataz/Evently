
import 'package:evently/Core/App%20Colors/main_colors.dart';
import 'package:evently/Features/Home%20Screen/persentation/View%20model/home_screen_states.dart';
import 'package:evently/Features/Home%20Screen/persentation/View%20model/home_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../Core/App Routing/routes.dart';
import 'Tabs/Fav Tab/persentation/fav_tab.dart';
import 'Tabs/Home Tab/persentation/home_tab.dart';
import 'Tabs/Map Tab/persentation/map_tab.dart';
import 'Tabs/Profile Tab/persentation/profile_tab.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>HomeScreenViewModel() ,
      child: BlocBuilder<HomeScreenViewModel,HomeScreenState>(
          builder: (context, state) {
            return Scaffold(
                floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
                floatingActionButton: FloatingActionButton(
                  onPressed: (){
                    Navigator.pushNamed(context, Routes.formEventScreenRouteName);
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(75.r),
                      side: BorderSide(
                        color:MainColors.getLightColor(),
                        width: 5,
                      )
                  ),
                  child: Icon(Icons.add,color:MainColors.getLightColor(),size: 30,),
                ),
                bottomNavigationBar: BottomNavigationBar(
                    currentIndex: state.currentTabIndex,
                    onTap: (value){
                      context
                          .read<HomeScreenViewModel>()
                          .setCurrTab(value);
                    },
                    selectedLabelStyle: GoogleFonts.inter(
                      color: MainColors.getLightColor(),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      height: 1,
                      letterSpacing: 0,
                    ),
                    type: BottomNavigationBarType.fixed,
                    unselectedItemColor:MainColors.getMainColor(),
                    selectedItemColor:MainColors.getLightColor(),
                    iconSize: 24,
                    showSelectedLabels: true,
                    showUnselectedLabels: false,
                    items: [
                      BottomNavigationBarItem(icon: Icon(Icons.home_filled,color: MainColors.getLightColor()),label: "Home"),
                      BottomNavigationBarItem(icon: Icon(Icons.location_on_outlined,color: MainColors.getLightColor()),label: "Map"),
                      BottomNavigationBarItem(icon: Icon(Icons.favorite_border,color: MainColors.getLightColor()),label: "Love"),
                      BottomNavigationBarItem(icon: Icon(Icons.person,color: MainColors.getLightColor()),label: "Profile"),
                    ]),
                body: returnTab(state.currentTabIndex)
            );
          },

      ));
  }
  Widget returnTab(int currTab){
    if(currTab==0){
      return HomeTab();
    }
    else if(currTab==1){
      return MapTab();
    }
    else if(currTab==2){
      return FavTab();
    }
    return ProfileTab();
  }
}
