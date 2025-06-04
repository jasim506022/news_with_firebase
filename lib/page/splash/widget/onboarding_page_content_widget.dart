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

class OnboardingPageContentWidget extends StatelessWidget {
  const OnboardingPageContentWidget({super.key, required this.onboardModel});

  final OnboardModel onboardModel;

  @override
  Widget build(BuildContext context) {
    return Consumer<OnboardingProvider>(
      builder: (context, onboardingProvider, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              onboardModel.image,
              height: 300.h,
              fit: BoxFit.fill,
            ),
            AppFunction.verticalSpace(10),
            const OnboardingProgressDotsWidget(),
            Text(
              onboardModel.title,
              textAlign: TextAlign.center,
              style: AppTextStyle.titleLargeTextStyle.copyWith(
                color: onboardingProvider.currentIndex % 2 == 0
                    ? Theme.of(context).primaryColor
                    : AppColors.white,
              ),
            ),
            Text(
              onboardModel.description,
              textAlign: TextAlign.center,
              style: AppTextStyle.mediumBoldTextStyle(context),
            ),
            const NextActionButton(),
            AppFunction.verticalSpace(20),
          ],
        );
      },
    );
  }
}
