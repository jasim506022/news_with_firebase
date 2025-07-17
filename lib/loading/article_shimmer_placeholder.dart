import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../res/app_colors.dart';
import '../res/app_function.dart';

/// A shimmer placeholder for an article list item.
/// Simulates image, title, and metadata layout.
class ArticleShimmerPlaceholder extends StatelessWidget {
  const ArticleShimmerPlaceholder({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.grey.shade200,
      highlightColor: AppColors.grey.shade300,
      child: Container(
        height: 140.h,
        width: 1.sw * 0.9,
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.1),
            blurRadius: 5,
            spreadRadius: .5,
            offset: const Offset(0, 5),
          ),
        ]),
        child: Column(
          children: [
            Align(
                alignment: Alignment.centerRight,
                child: _buildShimmerBox(isCircle: true, height: 15, width: 15)),
            Expanded(
              child: Row(
                children: [
                  _buildShimmerBox(height: 80, width: 100, radius: 15),
                  AppFunction.horizontalSpace(15),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildShimmerBox(height: 15, width: 280, radius: 15),
                        _buildShimmerBox(height: 15, width: 280, radius: 15),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(
                              3,
                              (_) => _buildShimmerBox(
                                  height: 15, width: 40, radius: 4),
                            ))
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerBox({
    required double height,
    required double width,
    double radius = 8,
    bool isCircle = false,
  }) {
    return Container(
      height: height.h,
      width: width.w,
      decoration: BoxDecoration(
        color: AppColors.grey.shade700,
        shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: isCircle ? null : BorderRadius.circular(radius.r),
      ),
    );
  }
}
