import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../res/app_colors.dart';
import '../../../res/app_function.dart';
import '../../../res/app_text_style.dart';

class AuthIntroWidget extends StatelessWidget {
  const AuthIntroWidget({
    super.key,
    required this.imageAssetPath,
    required this.title,
    required this.subTitle,
  });

  final String imageAssetPath;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 25.h),
      child: Column(
        children: [
          // Top image banner
          Image.asset(imageAssetPath, height: 200.h, width: double.infinity),
          AppFunction.verticalSpace(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title, style: AppTextStyle.authTitle),
              AppFunction.horizontalSpace(10),
              Icon(
                Icons.person_2_outlined,
                size: 35.r,
                color: AppColors.pink,
              )
            ],
          ),
          AppFunction.verticalSpace(7),
          Text(
            subTitle,
            style: AppTextStyle.authDescription,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
