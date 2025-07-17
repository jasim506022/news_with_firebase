import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../res/app_colors.dart';
import '../widget/common_swiper_widget.dart';

/// Displays a shimmer loading placeholder used as a skeleton
/// while data is being fetched asynchronously.
/// Shows multiple shimmer cards in a swiper-style carousel.
class LoadingPlaceholderShaderMaskWidget extends StatelessWidget {
  const LoadingPlaceholderShaderMaskWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CommonSwiperWidget(
      itemCount: 5,
      itemBuilder: (BuildContext context, int index) {
        return SizedBox(
          height: 200.h,
          width: 1.sw,
          child: Shimmer.fromColors(
            baseColor: AppColors.grey.shade200,
            highlightColor: AppColors.grey.shade300,
            child: Container(
              height: 180.h,
              width: 1.sw,
              decoration: BoxDecoration(
                  color: AppColors.grey.shade400,
                  borderRadius: BorderRadius.circular(15.r)),
            ),
          ),
        );
      },
    );
  }
}
