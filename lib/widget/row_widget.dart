import 'package:flutter/material.dart';

import '../res/app_string.dart';
import '../res/app_text_style.dart';

class RowWidget extends StatelessWidget {
  const RowWidget({
    super.key,
    required this.title,
    required this.onTap,
  });

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppTextStyle.titleTextSTyle(context)),
        InkWell(
          onTap: onTap,
          child: Text(AppString.seeAll,
              style: AppTextStyle.mediumBoldTextStyle(context)),
        ),
      ],
    );
  }
}

// When use Function and When use Void Call Back