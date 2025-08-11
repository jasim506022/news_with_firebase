import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../res/app_colors.dart';
import '../res/app_text_style.dart';
import '../res/network_utilis.dart';

class RichTextWidget extends StatelessWidget {
  /// - [normalText] is the non-clickable portion of the text.
  /// - [highlightedText] is the tappable portion of the text.
  /// - [onTap] is the function executed when the highlighted text is tapped.

  const RichTextWidget({
    super.key,
    required this.normalText,
    required this.highlightedText,
    required this.onTap,
  });

  final String normalText;
  final String highlightedText;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(
        text: "$normalText ",
        style: AppTextStyle.bodyMedium(context)
            .copyWith(fontWeight: FontWeight.bold),
      ),
      TextSpan(
        text: highlightedText,
        style: AppTextStyle.buttonTextStyle().copyWith(
            decoration: TextDecoration.underline, color: AppColors.red),
        recognizer: TapGestureRecognizer()
          ..onTap = () async => await NetworkUtils.executeWithInternetCheck(
              action: onTap, context: context),
      ),
    ]));
  }
}
