import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../res/app_colors.dart';
import '../res/app_text_style.dart';
import '../res/network_utilis.dart';

/// A widget that displays a line of text with a tappable highlighted portion.
///
/// - [normalText] is the regular, non-clickable part.
/// - [highlightedText] is the clickable, styled part of the text.
/// - [onTap] is the callback executed when the highlighted text is tapped.
///

class RichTextWidget extends StatelessWidget {
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
