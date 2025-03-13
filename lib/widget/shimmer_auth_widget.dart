import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerAutoWidget extends StatelessWidget {
  const ShimmerAutoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Swiper(
      itemBuilder: (BuildContext context, int index) {
        return SizedBox(
          height: 200.h,
          width: 1.sw,
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade200,
            highlightColor: Colors.grey.shade400,
            child: Container(
              height: 180.h,
              width: 1.sw,
              decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(15.r)),
            ),
          ),
        );
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
