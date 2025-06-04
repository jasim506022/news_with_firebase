import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';

import '../../../res/app_colors.dart';
import '../../../res/app_function.dart';
import '../../../res/app_string.dart';
import '../../../res/app_text_style.dart';
import '../../../service/other/onbaording_data.dart';
import '../../../service/provider/onboarding_provide.dart';

class NextActionButton extends StatelessWidget {
  const NextActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<OnboardingProvider>(
      builder: (context, onboardingProvider, child) {
        final isEvenIndex = onboardingProvider.currentIndex % 2 == 0;
        return InkWell(
          onTap: () => onboardingProvider.nextPage(context),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.h),
            decoration: BoxDecoration(
              color: isEvenIndex
                  ? Theme.of(context).primaryColor
                  : AppColors.black,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                    onboardingProvider.currentIndex ==
                            OnboardingDataList.onboardModeList.length - 1
                        ? AppString.btnFinish
                        : AppString.btnNext,
                    style: AppTextStyle.button),
                SizedBox(width: 15.w),
                AppFunction.horizontalSpace(15),
                Icon(Icons.arrow_forward_sharp, color: AppColors.white),
              ],
            ),
          ),
        );
      },
    );
  }
}
