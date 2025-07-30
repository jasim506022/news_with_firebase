import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../res/app_images.dart';
import '../res/app_text_style.dart';

/// A widget to display when there are no results found or to show a message.
/// Displays a centered image with a styled text message positioned above it.
class NoResultsWidget extends StatelessWidget {
  const NoResultsWidget({
    super.key,
    required this.title,
  });

  final String title;
  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: Center(
            child: Stack(
      children: [
        // Background image indicating empty results or no content
        Image.asset(AppImages.emptyNewsImage),
        // Positioned text over the image, centered and styled
        Positioned(
          top: 40.h,
          left: 220.w,
          right: 10.w,
          child: Text(
            title,
            maxLines: null,
            textAlign: TextAlign.center,
            style: AppTextStyle.noResultsTextStyle,
          ),
        ),
      ],
    )));
  }
}
