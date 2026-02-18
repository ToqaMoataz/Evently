
import 'package:easy_localization/easy_localization.dart';
import 'package:evently/Core/App%20Colors/main_colors.dart';
import 'package:evently/Core/Dependency%20Injection/di.dart';
import 'package:evently/Core/Provider/themeProvider.dart';
import 'package:evently/Core/assets/const%20data.dart';
import 'package:evently/Features/Home%20Screen/persentation/View%20model/home_screen_states.dart';
import 'package:evently/Features/Home%20Screen/persentation/View%20model/home_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../Core/App Routing/routes.dart';
import '../../../../Core/Models/user_model.dart';
import '../../../../Core/Provider/network_info_provider.dart';
import '../Tabs/Fav Tab/persentation/Tab/fav_tab.dart';
import '../Tabs/Home Tab/persentation/Tab/home_tab.dart';
import '../Tabs/Map Tab/persentation/Tab/map_tab.dart';
import '../Tabs/Profile Tab/persentation/Tab/profile_tab.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final HomeScreenViewModel viewModel=getIt<HomeScreenViewModel>();
  @override
  Widget build(BuildContext context) {
    var networkProvider = Provider.of<NetworkProvider>(context);
    return BlocProvider(
      create: (context) =>viewModel..getCurrUser(networkProvider.isOnline) ,
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
                    iconSize: 24,
                    items: [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.home_outlined),
                        activeIcon: Icon(Icons.home_filled),
                        label: "home_text".tr(),
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.location_on_outlined),
                        activeIcon: Icon(Icons.location_on),
                        label: "map_text".tr(),
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.favorite_border),
                        activeIcon: Icon(Icons.favorite),
                        label: "love_text".tr(),
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.person_outline),
                        activeIcon: Icon(Icons.person),
                        label: "profile_text".tr(),
                      ),
                    ]),
                body: (state.getUserInfoRequestState==RequestState.loading) ? Center( child: CircularProgressIndicator(color: MainColors.getMainColor(),)) : returnTab(state.currentTabIndex,state.currUser!)
            );
          },

      ));
  }
  Widget returnTab(int currTab,UserModel user){
    if(currTab==0){
      return HomeTab(user: user,);
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
