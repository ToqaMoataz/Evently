import 'package:easy_localization/easy_localization.dart';
import 'package:evently/Core/Dependency%20Injection/di.dart';
import 'package:evently/Core/Models/user_model.dart';
import 'package:evently/Core/Provider/language_setter.dart';
import 'package:evently/Features/Home%20Screen/persentation/Components/event_card.dart';
import 'package:evently/Features/Home%20Screen/persentation/Tabs/Home%20Tab/persentation/Cubit/home_tab_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../../../../Core/App Colors/main_colors.dart';
import '../../../../../../../Core/App Text Styles/app_textstyles.dart';
import '../../../../../../../Core/Provider/themeProvider.dart';
import '../../../../../../../Core/assets/const data.dart';
import '../Cubit/home_tab_view_model.dart';

class HomeTab extends StatefulWidget {
  final UserModel user;
  const HomeTab({super.key,required this.user});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  HomeTabViewModel viewModel = getIt<HomeTabViewModel>();

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);

    return BlocProvider(
      create:
          (context) =>
              viewModel
                ..getUserLocation()
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
                            style: AppTextStyles.titleSmall(
                              weight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            widget.user.name,
                            style: AppTextStyles.userNameTextStyle(),
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
                            icon: Icon(Icons.sunny, color: MainColors.getLightColor()),
                          ),
                          SizedBox(width: 3.w),
                          GestureDetector(
                            onTap: () {
                              LanguageChanger.changeLan(context);
                            },
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadiusGeometry.circular(
                                  8.r,
                                ),
                                color: MainColors.getLightColor(),
                              ),
                              child: Text(
                                (context.locale.toString() == 'en')
                                    ? "language_en_abbr".tr()
                                    : "language_ar_abbr".tr(),
                                style: GoogleFonts.inter(
                                  color:
                                      (isLightTheme)
                                          ? MainColors.getMainColor()
                                          : MainColors.getDarkColor(),
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
                        color: MainColors.getLightColor(),
                      ),
                      SizedBox(width: 3.w),
                      Text(
                        state.userLocation ?? "location_label_text".tr(),
                        style: AppTextStyles.titleSmall(
                          weight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: SizedBox(
                      height: 50.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: AppData.eventsDisplay.length,
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
                                    SizedBox(width: 8.w),
                                    Text(
                                      AppData.eventsDisplay[i].tr(),
                                      style: AppTextStyles.categoryCardTextStyle(
                                        color:
                                            (state.categoryIndex == i)
                                                ? ((isLightTheme)
                                                    ? MainColors.getMainColor()
                                                    : MainColors.getLightColor())
                                                : MainColors.getLightColor(),
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
            (state.getEventsRequestState==RequestState.loading) 
                ? Center(child: CircularProgressIndicator(color: MainColors.getMainColor(),))
                : (viewModel.state.events.isEmpty)
                    ? Center(child: Text("no_events_text".tr()))
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
