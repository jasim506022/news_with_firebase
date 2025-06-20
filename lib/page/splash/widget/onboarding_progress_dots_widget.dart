import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';

import '../../../res/app_colors.dart';
import '../../../service/other/onbaording_data.dart';
import '../../../service/provider/onboarding_provide.dart';

class OnboardingProgressDotsWidget extends StatelessWidget {
  const OnboardingProgressDotsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<OnboardingProvider>(
      builder: (context, onboardingProvider, child) {
        return SizedBox(
          height: 10.h,
          child: ListView.builder(
            itemCount: OnboardingDataList.onboardModeList.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 8.h,
                    width: 8.h,
                    margin: EdgeInsets.symmetric(horizontal: 3.w),
                    decoration: BoxDecoration(
                      color: onboardingProvider.currentIndex == index
                          ? AppColors.red
                          : AppColors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
