import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../res/app_colors.dart';
import '../../../res/app_function.dart';
import '../../../res/app_text_style.dart';

/// A reusable widget that displays an intro section with an image, title, and subtitle.
/// Commonly used on authentication screens like login or signup.
class AuthHeaderSection extends StatelessWidget {
  const AuthHeaderSection({
    super.key,
    required this.imageAssetPath,
    required this.title,
    required this.subtitle,
  });

  final String imageAssetPath;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 25.h),
      child: Column(
        children: [
          // Top image banner
          Image.asset(
            imageAssetPath,
            height: 200.h,
            width: double.infinity,
            fit: BoxFit.contain,
          ),
          // Why need boxFit.Contain
          AppFunction.verticalSpace(20),
          // Title with icon
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
          // Subtitle
          Text(
            subtitle,
            style: AppTextStyle.authDescription,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
