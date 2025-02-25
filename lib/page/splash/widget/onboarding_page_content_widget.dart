import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsapps/model/onboard_model.dart';
import 'package:newsapps/res/app_colors.dart';
import 'package:provider/provider.dart';

import '../../../res/app_text_style.dart';
import '../../../service/provider/onboarding_provide.dart';
import 'next_action_button.dart';
import 'onboarding_progress_dots_widget.dart';

class OnboardingPageContentWidget extends StatelessWidget {
  const OnboardingPageContentWidget({super.key, required this.onboardingItem});

  final OnboardModel onboardingItem;

  @override
  Widget build(BuildContext context) {
    return Consumer<OnboardingProvider>(
      builder: (context, onboardingProvider, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              onboardingItem.image,
              height: 300.h,
              fit: BoxFit.fill,
            ),
            SizedBox(height: 10.h),
            const OnboardingProgressDotsWidget(),
            Text(
              onboardingItem.title,
              textAlign: TextAlign.center,
              style: AppTextStyle.titleLargeTextStyle.copyWith(
                color: onboardingProvider.currentIndex % 2 == 0
                    ? Theme.of(context).primaryColor
                    : AppColors.white,
              ),
            ),
            Text(
              onboardingItem.description,
              textAlign: TextAlign.center,
              style: AppTextStyle.mediumBoldTextStyle(context),
            ),
            const NextActionButton(),
            SizedBox(height: 20.h),
          ],
        );
      },
    );
  }
}
