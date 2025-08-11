import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';

import '../../../res/app_colors.dart';
import '../../../res/app_function.dart';
import '../../../res/app_string.dart';
import '../../../res/app_text_style.dart';
import '../../../service/other/onbaording_data.dart';
import '../../../service/provider/onboarding_provide.dart';

/// A button widget that advances the onboarding sequence.
///
/// Shows "Next" or "Finish" based on current onboarding page.
/// Button color alternates depending on current page index parity.

class NextActionButton extends StatelessWidget {
  const NextActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<OnboardingProvider>(
      builder: (context, provider, _) {
        // Determine parity of current onboarding page index for styling.
        final bool isEvenIndex = provider.currentIndex % 2 == 0;

        // Check if this is the last onboarding page.
        final bool isLastPage = provider.currentIndex ==
            OnboardingDataList.onboardModeList.length - 1;

        return InkWell(
          onTap: () => provider.nextPage(context),
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
                Text(isLastPage ? AppString.btnFinish : AppString.btnNext,
                    style: AppTextStyle.buttonTextStyle()),
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
