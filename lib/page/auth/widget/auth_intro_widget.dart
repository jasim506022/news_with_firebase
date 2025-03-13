import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../res/app_colors.dart';
import '../../../res/app_images.dart';
import '../../../res/app_string.dart';
import '../../../res/app_text_style.dart';

class AuthIntroWidget extends StatelessWidget {
  const AuthIntroWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 25.h),
      child: Column(
        children: [
          Image(
            image: const AssetImage(AppImages.appIntroImage),
            height: 150.h,
            width: double.infinity,
          ),
          SizedBox(
            height: 20.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(AppString.btnLogin, style: AppTextStyle.authTitle),
              const SizedBox(
                width: 10,
              ),
              Icon(
                Icons.person_2_outlined,
                size: 35.h,
                color: AppColors.pink,
              )
            ],
          ),
          SizedBox(height: 7.h),
          Text("Welcome to Jasim Uddin News",
              style: AppTextStyle.authDescription),
        ],
      ),
    );
  }
}
