import 'package:easy_localization/easy_localization.dart';
import 'package:evently/Core/Provider/language_provider.dart';
import 'package:evently/Core/Text%20Styles/app_textstyles.dart';
import 'package:evently/Features/Home%20Screen/domain/Usecase/get_curr_user_usecas.dart';
import 'package:evently/Features/Home%20Screen/persentation/Components/event_card.dart';
import 'package:evently/Features/Home%20Screen/persentation/Tabs/Home%20Tab/data/Data%20source/home_tab_ds.dart';
import 'package:evently/Features/Home%20Screen/persentation/Tabs/Home%20Tab/data/Repository%20IMP/home_rep_impl.dart';
import 'package:evently/Features/Home%20Screen/persentation/Tabs/Home%20Tab/domain/Usecase/get_events_usecase.dart';
import 'package:evently/Features/Home%20Screen/persentation/Tabs/Home%20Tab/persentation/home_tab_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:evently/Core/Color/main_colors.dart';
import 'package:provider/provider.dart';
import '../../../../../../Core/Provider/themeProvider.dart';
import '../../../../../../Core/assets/const data.dart';
import '../../../../data/Repository Implementation/repo_impl.dart';
import '../../../../data/datasource/home_screen_ds.dart';
import '../../../../domain/Usecase/update_fave.dart';
import 'home_tab_view_model.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  HomeTabViewModel viewModel = HomeTabViewModel(
    userUseCase: GetCurrUserUC(HomeScreenRepoImp(HomeScreenDSImp())),
    eventsUseCase: GetEventsUC(HomeRepoImp(HomeTabDSImp())),
    favUseCase: UpdateFavUC(HomeScreenRepoImp(HomeScreenDSImp())),
  );

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    var lanProvider = Provider.of<LanguageProvider>(context);
    return BlocProvider(
      create:
          (context) =>
              viewModel
                ..getCurrUser()
                ..getEvents(AppData.events[viewModel.state.categoryIndex]),
      child: BlocBuilder<HomeTabViewModel, HomeTabState>(
        builder: (context, state) {
          bool isLightTheme = themeProvider.themeMode == ThemeMode.light;
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              centerTitle: false,
              titleSpacing: 16,
              toolbarHeight: 175.h,
              backgroundColor:
                  (isLightTheme)
                      ? MainColors.getMainColor()
                      : Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24.r),
                  bottomRight: Radius.circular(24.r),
                ),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "welcome_back_text".tr(),
                            style: AppTextStyles.small400TitleStyle(),
                          ),
                          Text(
                            state.currUser?.name ?? "username_text".tr(),
                            style: AppTextStyles.largeTitleStyle(),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              if (isLightTheme) {
                                themeProvider.changeTheme(ThemeMode.dark);
                              } else {
                                themeProvider.changeTheme(ThemeMode.light);
                              }
                            },
                            icon: Icon(Icons.sunny, color: Color(0XFFF2FEFF)),
                          ),
                          SizedBox(width: 3.w),
                          GestureDetector(
                            onTap: () {
                              lanProvider.changeLan(context);
                            },
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadiusGeometry.circular(
                                  8.r,
                                ),
                                color: Color(0XFFF2FEFF),
                              ),
                              child: Text(
                                (context.locale.toString() == 'en')
                                    ? "language_en".tr()
                                    : "language_ar".tr(),
                                style: GoogleFonts.inter(
                                  color:
                                      (isLightTheme)
                                          ? MainColors.getMainColor()
                                          : MainColors.getTDarkColor(),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                  height: 1,
                                  letterSpacing: 0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: 8.h),
                  //Location
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: Color(0XFFF2FEFF),
                      ),
                      SizedBox(width: 3.w),
                      Text(
                        state.currUser?.location ?? "location_text".tr(),
                        style: AppTextStyles.small500TitleStyle(),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: SizedBox(
                      height: 50.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: AppData.events.length,
                        itemBuilder: (context, i) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: GestureDetector(
                              onTap: () {
                                viewModel.setCurrEvent(i);
                                viewModel.getEvents(
                                  AppData.events[viewModel.state.categoryIndex],
                                );
                              },
                              child: Container(
                                height: 40.h,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      (state.categoryIndex == i)
                                          ? (isLightTheme)
                                              ? MainColors.getLightColor()
                                              : MainColors.getMainColor()
                                          : Colors.transparent,
                                  borderRadius: BorderRadius.circular(37.r),
                                  border: Border.all(
                                    color:
                                        (isLightTheme)
                                            ? MainColors.getLightColor()
                                            : MainColors.getMainColor(),
                                    width: 1,
                                    style:
                                        (state.categoryIndex == i)
                                            ? BorderStyle.none
                                            : BorderStyle.solid,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      AppData.eventIcon[i],
                                      color:
                                          (state.categoryIndex == i)
                                              ? ((isLightTheme)
                                                  ? MainColors.getMainColor()
                                                  : MainColors.getLightColor())
                                              : MainColors.getLightColor(),
                                      size: 24,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      AppData.events[i],
                                      style: GoogleFonts.inter(
                                        color:
                                            (state.categoryIndex == i)
                                                ? ((isLightTheme)
                                                    ? MainColors.getMainColor()
                                                    : MainColors.getLightColor())
                                                : MainColors.getLightColor(),
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
            body:
                (viewModel.state.events.isEmpty)
                    ? Center(child: Text("Currently no events"))
                    : Padding(
                      padding: const EdgeInsets.only(
                        top: 16,
                        left: 16,
                        right: 16,
                      ),
                      child: ListView.separated(
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 16.h);
                        },
                        itemCount: state.events.length,
                        itemBuilder: (context, index) {
                          return EventCard(
                            event: state.events[index],
                            updateFav: () {
                              viewModel.updateFave(
                                state.events[index].id,
                                state.events[index].isFav,
                              );
                            },
                          );
                        },
                      ),
                    ),
          );
        },
      ),
    );
  }
}
