import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsapps/res/app_function.dart';

import '../res/app_string.dart';
import '../res/app_text_style.dart';

/// A reusable row with a title on the left and a tappable "See All" on the right.
/// Used as a section header (e.g., for news, products, categories).
class SectionHeaderRow extends StatelessWidget {
  const SectionHeaderRow({
    super.key,
    required this.title,
    required this.onTap,
  });

  /// The section title displayed on the left
  final String title;

  /// Callback triggered when "See All" is tapped
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppTextStyle.titleTextStyle(context)),
        InkWell(
          onTap: onTap,
          child: Row(
            children: [
              Text(AppString.btnSeeAll,
                  style: AppTextStyle.mediumBoldTextStyle(context)),
              AppFunction.horizontalSpace(4),
              Icon(Icons.arrow_forward_ios, size: 14.sp),
            ],
          ),
        ),
      ],
    );
  }
}

/*
Imagine you're giving someone instructions:

✅ onTap: onTap → You're handing them the instructions, saying "Do this later when needed."

❌ onTap: onTap() → You're doing the task now, and handing them the result (which is nothing useful).
*/