import 'package:easy_localization/easy_localization.dart';
import 'package:evently/Core/Dependency%20Injection/di.dart';
import 'package:evently/Core/assets/const%20data.dart';
import 'package:evently/Features/Home%20Screen/persentation/Tabs/Profile%20Tab/data/Const%20Data/const_data.dart';
import 'package:evently/Features/Home%20Screen/persentation/Tabs/Profile%20Tab/persentation/Cubit/profile_states.dart';
import 'package:evently/Features/Home%20Screen/persentation/Tabs/Profile%20Tab/persentation/Cubit/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../../../../Core/App Colors/main_colors.dart';
import '../../../../../../../Core/App Routing/routes.dart';
import '../../../../../../../Core/App Text Styles/app_textstyles.dart';
import '../../../../../../../Core/Provider/language_setter.dart';
import '../../../../../../../Core/Provider/themeProvider.dart';


class ProfileTab extends StatelessWidget {
  ProfileTab({super.key});

  final ProfileViewModel viewModel = getIt<ProfileViewModel>();

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return BlocProvider(
      create: (context) => viewModel..getCurrUser(),
      child: BlocConsumer<ProfileViewModel, ProfileState>(
        builder: (context, state) {
          if (state.getUserInfoRequestState == RequestState.error) {
            return Center(child: Text(state.errorMessage ?? ""));
          } else if (state.getUserInfoRequestState == RequestState.loading) {
            return Center(
              child: CircularProgressIndicator(
                color: MainColors.getMainColor(),
              ),
            );
          }
          return Scaffold(
            appBar: AppBar(
              toolbarHeight: 175.h,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(64.r),
                ),
              ),
              backgroundColor: MainColors.getMainColor(),
              title: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    //User Image
                    GestureDetector(
                      onDoubleTap: () {
                        viewModel.uploadUserImage();
                      },
                      onTap: () {},
                      child: SizedBox(
                        height: 124.w,
                        width: 124.w,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24.r),
                            topRight: Radius.circular(1000.r),
                            bottomLeft: Radius.circular(1000.r),
                            bottomRight: Radius.circular(1000.r),
                          ),
                          child: Image.network(
                            state.currUser!.imageUrl,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }
                              return CircularProgressIndicator(
                                color: MainColors.getLightColor(),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16.w),
                    // User name and mail
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.currUser!.name,
                            style: AppTextStyles.userNameTextStyle(),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            state.currUser!.email,
                            style: AppTextStyles.titleMedium(),
                            softWrap: true,
                            overflow: TextOverflow.clip,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 16.h,
                children: [
                  Text(
                    "language_text".tr(),
                    style: GoogleFonts.inter(
                      color:
                          (themeProvider.themeMode == ThemeMode.light)
                              ? MainColors.getDarkColor()
                              : MainColors.getLightColor(),
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  DropdownButtonFormField<String>(
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: MainColors.getMainColor(),
                    ),
                    dropdownColor: MainColors.getLightColor(),
                    itemHeight: 56.h,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: MainColors.getMainColor(),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: MainColors.getMainColor(),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: MainColors.getMainColor(),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      filled: true,
                      fillColor: Colors.transparent,
                      contentPadding: EdgeInsets.all(16),
                    ),
                    initialValue:
                        (context.locale.toString() == 'en')
                            ? ProfileConstData.languages[1]
                            : ProfileConstData.languages[0],
                    items:
                        ProfileConstData.languages.map((lang) {
                          return DropdownMenuItem(
                            value: lang,
                            child: Text(
                              lang.tr(),
                              style: GoogleFonts.inter(
                                color: MainColors.getMainColor(),
                              ),
                            ),
                          );
                        }).toList(),
                    onChanged: (val) {
                      LanguageChanger.changeLan(context, lang: val);
                    },
                  ),
                  Text(
                    "theme_text".tr(),
                    style: GoogleFonts.inter(
                      color:
                          (themeProvider.themeMode == ThemeMode.light)
                              ? MainColors.getDarkColor()
                              : MainColors.getLightColor(),
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  DropdownButtonFormField<String>(
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: MainColors.getMainColor(),
                    ),
                    dropdownColor: MainColors.getLightColor(),
                    itemHeight: 56.h,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: MainColors.getMainColor(),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: MainColors.getMainColor(),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: MainColors.getMainColor(),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      filled: true,
                      fillColor: Colors.transparent,
                      contentPadding: EdgeInsets.all(16),
                    ),
                    initialValue: ProfileConstData.getCurrentTheme(context),
                    items:
                        ProfileConstData.themes.map((theme) {
                          return DropdownMenuItem(
                            value: theme,
                            child: Text(
                              theme.tr(),
                              style: GoogleFonts.inter(
                                color: MainColors.getMainColor(),
                              ),
                            ),
                          );
                        }).toList(),
                    onChanged: (val) {
                      if (val == "theme_light") {
                        themeProvider.changeTheme(ThemeMode.light);
                      } else {
                        themeProvider.changeTheme(ThemeMode.dark);
                      }
                    },
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder:
                            (_) => AlertDialog(
                              title: Text("confirm_logout_title".tr(),style: AppTextStyles.labelLarge(color: MainColors.getMainColor()),),
                              content: Text("logout_message".tr(),style: AppTextStyles.bodySmall(color: MainColors.getMainColor())),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text("no_text".tr()),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    viewModel.logout();
                                  },
                                  child: Text("yes_text".tr()),
                                ),
                              ],
                            ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: MainColors.getRedColor(),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.logout_sharp,
                            color: MainColors.getLightColor(),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            "logout_text".tr(),
                            style: GoogleFonts.inter(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w400,
                              color: MainColors.getLightColor(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        listener: (context, state) {
          if (state.logoutRequestState == RequestState.success) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.loginScreenRouteName,
              (route) => false,
            );
          }
        },
      ),
    );
  }
}
