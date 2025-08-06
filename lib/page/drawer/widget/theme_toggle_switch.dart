import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsapps/res/app_string.dart';
import 'package:provider/provider.dart';

import '../../../res/app_text_style.dart';
import '../../../service/provider/theme_mode_provider.dart';

/// A reusable widget that toggles the app's theme between Dark and Light modes.
/// Uses Provider's ThemeProvider to get and set the theme state.
class ThemeToggleSwitch extends StatelessWidget {
  const ThemeToggleSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the current theme state from ThemeProvider
    final themeProvider = Provider.of<ThemeModeProvider>(context);
    final isDarkMode = themeProvider.isDarkTheme;

    // Use icon color from the current theme for consistency
    final iconColor = Theme.of(context).iconTheme.color;

    return SwitchListTile(
      title: Text(isDarkMode ? AppString.darkLabel : AppString.lightLabel,
          style:
              AppTextStyle.titleTextStyle(context).copyWith(color: iconColor)),
      secondary: Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode,
          size: 25.sp, color: iconColor),
      value: isDarkMode,
      onChanged: (value) => themeProvider.setDarkTheme(value),
    );
  }
}
