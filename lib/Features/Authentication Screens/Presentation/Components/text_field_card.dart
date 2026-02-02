import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../Core/App Text Styles/app_textstyles.dart';
import '../../../../Core/Provider/themeProvider.dart';

class TextFieldCard extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final TextEditingController textController;
  final String? Function(String?)? validate;
  final bool isPass;
  final bool passVisible;
  final VoidCallback? onVisibilityToggle;
  final Color color;

  const TextFieldCard({
    super.key,
    required this.hintText,
    required this.icon,
    required this.textController,
    required this.color,
    this.validate,
    this.isPass = false,
    this.passVisible = false,
    this.onVisibilityToggle,
  });

  @override
  Widget build(BuildContext context) {
    var themeProvider=Provider.of<ThemeProvider>(context);
    return Container(
      height: 56.h,
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color:color),
      ),
      child: Row(
        children: [
          Icon(icon, color: color),
          SizedBox(width: 16.w),
          Expanded(
            child: TextFormField(
              controller: textController,
              validator: validate,
              obscureText: isPass ? !passVisible : false,
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
                hintStyle: AppTextStyles.hintTextStyle(themeMode: themeProvider.themeMode),
              ),
            ),
          ),
          if (isPass)
            IconButton(
              onPressed: onVisibilityToggle,
              icon: Icon(
                passVisible
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: color,
              ),
            ),
        ],
      ),
    );
  }
}
