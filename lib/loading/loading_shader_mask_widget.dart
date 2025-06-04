import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../res/app_colors.dart';

class LoadingShaderMaskWidget extends StatelessWidget {
  const LoadingShaderMaskWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DefaulShammerWidget(
      widget: SizedBox(
        height: 200.h,
        width: 1.sw,
        child: Shimmer.fromColors(
          baseColor: AppColors.grey.shade200,
          highlightColor: AppColors.grey.shade400,
          child: Container(
            height: 180.h,
            width: 1.sw,
            decoration: BoxDecoration(
                color: AppColors.grey.shade400,
                borderRadius: BorderRadius.circular(15.r)),
          ),
        ),
      ),
    );
  }
}

class DefaulShammerWidget extends StatelessWidget {
  const DefaulShammerWidget({
    super.key,
    required this.widget,
  });
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Swiper(
      itemBuilder: (BuildContext context, int index) {
        return widget;
      },
      scale: .8,
      itemCount: 8,
      viewportFraction: .95,
      layout: SwiperLayout.DEFAULT,
      autoplay: true,
      autoplayDelay: 3000,
    );
  }
}
