import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../res/app_function.dart';
import '../res/app_images.dart';
import '../res/app_string.dart';
import '../res/app_text_style.dart';

/// A reusable widget to show a placeholder UI when no data is available.
/// Typically used in empty list or error states.

class NoDataPlaceholder extends StatelessWidget {
  const NoDataPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(height: 170.h, AppImages.emptyImageValue),
        AppFunction.verticalSpace(10),
        Text(AppString.noData, style: AppTextStyle.errorValue)
      ],
    );
  }
}

/*
mainAxisSize: MainAxisSize.min,
*/
