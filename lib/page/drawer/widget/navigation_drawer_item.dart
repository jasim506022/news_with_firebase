import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../res/app_text_style.dart';

/// A reusable drawer menu item used for app navigation.
///
/// Displays an icon and a title, and runs a callback when tapped.

class NavigationDrawerItem extends StatelessWidget {
  const NavigationDrawerItem({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    // Get icon/text color from current theme for consistency
    final iconColor = Theme.of(context).iconTheme.color;

    return ListTile(
      leading: Icon(icon, size: 25.sp, color: iconColor),
      title: Text(title,
          style:
              AppTextStyle.titleTextStyle(context).copyWith(color: iconColor)),
      onTap: onTap,
    );
  }
}



      // GoogleFonts.poppins(
          //   textStyle: TextStyle(
          //     color: iconColor,
          //     fontSize: 14,
          //     letterSpacing: 1,
          //     fontWeight: FontWeight.w600,
          //   ),
          // ),
