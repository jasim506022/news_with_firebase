import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../res/app_text_style.dart';
import '../res/app_colors.dart';

class AppLogoWidget extends StatelessWidget {
  const AppLogoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("JU", style: AppTextStyle.logoTitleTextStyle),
        SizedBox(
          height: 5.h,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
          decoration: BoxDecoration(
              color: AppColors.red, borderRadius: BorderRadius.circular(10)),
          child: Text("News", style: AppTextStyle.logoSubTitleStyle),
        )
      ],
    );
  }
}
