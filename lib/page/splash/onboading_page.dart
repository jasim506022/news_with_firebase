import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';

import '../../res/app_string.dart';
import '../../res/app_text_style.dart';
import '../../res/app_colors.dart';
import '../../service/other/onbaording_data.dart';
import '../../service/provider/onboarding_provide.dart';
import 'widget/onboarding_page_content_widget.dart';

/// OnboardingPage displays a sequence of onboarding screens with alternating background colors.
///
/// Uses [OnboardingProvider] to manage page state and navigation.

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<OnboardingProvider>(
      builder: (context, provider, child) {
        // Determine if current onboarding page index is even or odd for UI styling.
        final isEvenIndex = provider.currentIndex % 2 == 0;

        // Set background color based on page parity.
        final backgroundColor = isEvenIndex ? AppColors.white : AppColors.pink;

        // Button color toggles between primary color (for even pages) and white (for odd pages).
        final buttonTextColor =
            isEvenIndex ? Theme.of(context).primaryColor : AppColors.white;

        return Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            backgroundColor: backgroundColor,
            automaticallyImplyLeading: false,
            actions: [
              /// Skip button to exit onboarding early
              TextButton(
                onPressed: () => provider.completeOnboarding(context),
                child: Text(AppString.btnSkip,
                    style: AppTextStyle.buttonTextStyle()
                        .copyWith(color: buttonTextColor)),
              ),
            ],
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: PageView.builder(
              controller: provider.pageController,
              itemCount: OnboardingDataList.onboardModeList.length,
              onPageChanged: provider.updatePageIndex,
              itemBuilder: (context, index) {
                final onboardModel = OnboardingDataList.onboardModeList[index];
                // Display each onboarding page content
                return OnboardingPageContentWidget(onboardModel: onboardModel);
              },
            ),
          ),
        );
      },
    );
  }
}
