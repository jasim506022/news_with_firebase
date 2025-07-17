import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../res/app_text_style.dart';

/// A customizable outlined button widget.
///
/// Useful for consistent UI with theme-colored borders and text.
class OutlinedTextButtonWidget extends StatelessWidget {
  const OutlinedTextButtonWidget({
    super.key,
    required this.onPressed,
    required this.color,
    required this.title,
  });

  final VoidCallback onPressed;
  final Color color;
  final String title;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: color, width: 2.0.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0.w),
          ),
        ),
        onPressed: onPressed,
        child: Text(title, style: AppTextStyle.button.copyWith(color: color)));
  }
}
