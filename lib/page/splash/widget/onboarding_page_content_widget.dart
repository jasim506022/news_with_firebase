import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';

import '../../../model/onboard_model.dart';
import '../../../res/app_colors.dart';
import '../../../res/app_function.dart';
import '../../../res/app_text_style.dart';
import '../../../service/provider/onboarding_provide.dart';
import 'next_action_button.dart';
import 'onboarding_progress_dots_widget.dart';

/// Widget displaying the content of a single onboarding page.
///
/// Shows image, progress indicator, title, description, and navigation button.
/// Adapts styles based on the current onboarding page index.

class OnboardingPageContentWidget extends StatelessWidget {
  const OnboardingPageContentWidget({super.key, required this.onboardModel});

  final OnboardModel onboardModel;

  @override
  Widget build(BuildContext context) {
    return Consumer<OnboardingProvider>(
      builder: (context, provider, _) {
        // Determine if current page index is even or odd for styling.
        final bool isEvenIndex = provider.currentIndex % 2 == 0;
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Display onboarding image with fixed height and fill fit.
            Image.asset(
              onboardModel.image,
              height: 300.h,
              fit: BoxFit.fill,
            ),
            AppFunction.verticalSpace(10),
            // Indicator dots showing current onboarding progress.
            const OnboardingProgressDotsWidget(),
            Text(
              onboardModel.title,
              textAlign: TextAlign.center,
              style: AppTextStyle.titleLargeTextStyle.copyWith(
                color: isEvenIndex
                    ? Theme.of(context).primaryColor
                    : AppColors.white,
              ),
            ),
            Text(
              onboardModel.description,
              textAlign: TextAlign.center,
              style: AppTextStyle.bodyMedium(context)
                  .copyWith(fontWeight: FontWeight.w900),
            ),
            // Button for moving to next onboarding action.
            const NextActionButton(),
            AppFunction.verticalSpace(20),
          ],
        );
      },
    );
  }
}
