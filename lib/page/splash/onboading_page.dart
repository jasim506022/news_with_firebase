import 'package:flutter/material.dart';
import 'package:newsapps/service/onbaording_data_list.dart';

import 'package:provider/provider.dart';

import '../../res/app_string.dart';
import '../../res/app_text_style.dart';
import '../../res/app_colors.dart';
import '../../service/provider/onboarding_provide.dart';
import 'widget/onboarding_page_content_widget.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<OnboardingProvider>(
      builder: (context, onboardingProvider, child) {
        final isEvenIndex = onboardingProvider.currentIndex % 2 == 0;
        final backgroundColor = isEvenIndex ? AppColors.white : AppColors.pink;
        final buttonColor =
            isEvenIndex ? Theme.of(context).primaryColor : AppColors.white;
        return Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            backgroundColor: backgroundColor,
            automaticallyImplyLeading: false,
            actions: [
              TextButton(
                onPressed: () => onboardingProvider.completeOnboarding(context),
                child: Text(AppString.btnSkip,
                    style: AppTextStyle.button.copyWith(color: buttonColor)),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: PageView.builder(
              controller: onboardingProvider.pageController,
              itemCount: OnbaordingDataList.onboardModeList.length,
              onPageChanged: (value) =>
                  onboardingProvider.updatePageIndex(value),
              itemBuilder: (context, index) {
                return OnboardingPageContentWidget(
                  onboardingItem: OnbaordingDataList.onboardModeList[index],
                );
              },
            ),
          ),
        );
      },
    );
  }
}



/*
if (index == onboardModeList.length - 1) {
                        await newOnBoardInfo();
                        // ignore: use_build_context_synchronously
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ));
                      }
                      pageController.nextPage(
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.bounceIn);
*/