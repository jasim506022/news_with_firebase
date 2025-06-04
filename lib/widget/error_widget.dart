import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../res/app_images.dart';
import '../res/app_string.dart';
import '../res/app_text_style.dart';

class ErrorNullWidget extends StatelessWidget {
  const ErrorNullWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(height: 170.h, AppImages.emptyImageValue),
        SizedBox(height: 10.h),
        Text(AppString.noData, style: AppTextStyle.errorValue)
      ],
    );
  }
}
