import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:evently/Core/Color/main_colors.dart';
import 'package:evently/Provider/themeProvider.dart';
import 'package:evently/Screens/Authentication%20Screens/Components/text_field_card.dart';

import '../../../Core/Text Styles/app_textstyles.dart';

class FavTab extends StatefulWidget {
  FavTab(themeProvider, {super.key});
  late ThemeProvider themeProvider;
  @override
  State<FavTab> createState() => _FavTabState();
}

class _FavTabState extends State<FavTab> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController=TextEditingController();
  }

  @override
  void dispose(){
    super.dispose();
    _searchController.dispose();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 56.h,
            padding: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: MainColors.getMainColor()),
            ),
            child: Row(
              children: [
                SizedBox(width: 16.w),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: "search_for_event_text".tr(),
                      border: InputBorder.none,
                      hintStyle: AppTextStyles.textFieldStyle(widget.themeProvider),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
