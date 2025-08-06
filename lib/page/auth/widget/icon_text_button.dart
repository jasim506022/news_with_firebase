import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../res/app_colors.dart';
import '../../../res/app_function.dart';
import '../../../res/app_text_style.dart';
import '../../../res/network_utilis.dart';

/// A button widget that displays an icon alongside a label,
/// typically used for third-party sign-in options (e.g., Google, Phone).
/// Includes internet connectivity check before executing the tap action.
class IconTextButton extends StatelessWidget {
  const IconTextButton({
    super.key,
    // required this.loading,
    required this.label,
    required this.onTap,
    required this.iconAssetPath,
  });

  // final LoadingProvider loading;
  final String label;
  final VoidCallback onTap;
  final String iconAssetPath;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async => await NetworkUtils.executeWithInternetCheck(
          action: onTap, context: context),
      child: Container(
        height: 60.h,
        decoration: BoxDecoration(
            color: AppColors.white,
            border: Border.all(color: AppColors.deepred, width: 2),
            borderRadius: BorderRadius.circular(10.r)),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                height: 30.h,
                width: 30.h,
                image: AssetImage(iconAssetPath),
              ),
              AppFunction.horizontalSpace(15),
              Text(
                label,
                style: AppTextStyle.buttonTextStyle()
                    .copyWith(color: AppColors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
