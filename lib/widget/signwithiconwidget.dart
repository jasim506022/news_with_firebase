import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:newsapps/res/app_text_style.dart';

import '../res/app_colors.dart';

class SignWithIcon extends StatelessWidget {
  const SignWithIcon({
    super.key,
    // required this.loading,
    required this.text,
    required this.onTap,
    required this.image,
  });

  // final LoadingProvider loading;
  final String text;
  final VoidCallback onTap;
  final String image;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 60.h,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: AppColors.deepred, width: 2),
            borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                height: 30.h,
                width: 30.h,
                image: AssetImage(image),
              ),
              const SizedBox(width: 10),
              Text(
                text,
                style: AppTextStyle.button.copyWith(color: AppColors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
