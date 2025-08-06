import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';

import '../../res/app_string.dart';
import '../../res/app_text_style.dart';
import '../../res/app_colors.dart';
import '../../service/other/onbaording_data.dart';
import '../../service/provider/onboarding_provide.dart';
import 'widget/onboarding_page_content_widget.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<OnboardingProvider>(
      builder: (context, onboardingProvider, child) {
        // Decide alternating colors based on current index
        final isEvenIndex = onboardingProvider.currentIndex % 2 == 0;
        final backgroundColor = isEvenIndex ? AppColors.white : AppColors.pink;

        // 🆕 Changed buttonColor to use new deepBlue color when odd
        final buttonColor =
            isEvenIndex ? Theme.of(context).primaryColor : AppColors.white;

        return Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            backgroundColor: backgroundColor,
            automaticallyImplyLeading: false,
            actions: [
              // This now shows "Skip"
              TextButton(
                onPressed: () => onboardingProvider.completeOnboarding(context),
                child: Text(AppString.btnSkip,
                    style: AppTextStyle.buttonTextStyle()
                        .copyWith(color: buttonColor)),
              ),
            ],
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: PageView.builder(
              controller: onboardingProvider.pageController,
              itemCount: OnboardingDataList.onboardModeList.length,
              onPageChanged: onboardingProvider.updatePageIndex,
              itemBuilder: (context, index) {
                return OnboardingPageContentWidget(
                    onboardModel: OnboardingDataList.onboardModeList[index]);
              },
            ),
          ),
        );
      },
    );
  }
}
