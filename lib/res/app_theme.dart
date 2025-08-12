import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';
import 'app_text_style.dart';

/// A class that builds and returns app-wide [ThemeData]
/// depending on the light or dark mode state.
class AppTheme {
  final bool isDark;
  final BuildContext context;

  /// Creates an [AppTheme] instance.
  ///
  /// [isDark]: Whether the dark theme is active.
  /// [context]: The BuildContext used to get theme-based styles.
  AppTheme({required this.isDark, required this.context});

  ThemeData build() {
    return ThemeData(
      scaffoldBackgroundColor:
          _themeColor(AppColors.darkBackgroundColor, AppColors.white),
      primaryColor: _themeColor(AppColors.white, AppColors.black),
      cardColor: _themeColor(AppColors.darkCardColor, AppColors.white),
      iconTheme: _iconThemeData(),
      progressIndicatorTheme: _progressIndicatorTheme(),
      appBarTheme: _appBarTheme(),
      dialogTheme: _dialogTheme(),
      elevatedButtonTheme: _elevatedButtonTheme(),
      tabBarTheme: _tabBarTheme(),
    );
  }

  /// Returns a color depending on the theme.
  T _themeColor<T>(T dark, T light) => isDark ? dark : light;

  /// Icon color and size throughout the app.
  IconThemeData _iconThemeData() {
    return IconThemeData(
      color: _themeColor(AppColors.white, AppColors.black),
      size: 25.h,
    );
  }

  /// Style for circular and linear progress indicators.
  ProgressIndicatorThemeData _progressIndicatorTheme() {
    return ProgressIndicatorThemeData(
      color: AppColors.white,
      linearTrackColor: AppColors.green,
      circularTrackColor: AppColors.green,
      refreshBackgroundColor: AppColors.green,
    );
  }

  /// Styles for AppBar across the app.
  AppBarTheme _appBarTheme() {
    return AppBarTheme(
      backgroundColor: isDark ? AppColors.darkCardColor : AppColors.white,
      elevation: 0.0,
      centerTitle: true,
      iconTheme: _iconThemeData(),
      titleTextStyle: AppTextStyle.appBarTitle(context)
          .copyWith(color: _themeColor(AppColors.white, AppColors.red)),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor:
            _themeColor(AppColors.darkBackgroundColor, AppColors.white),
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        systemNavigationBarColor:
            _themeColor(AppColors.darkCardColor, AppColors.white),
        systemNavigationBarIconBrightness:
            isDark ? Brightness.light : Brightness.dark,
      ),
    );
  }

  /// Styles for dialog boxes throughout the app.
  DialogTheme _dialogTheme() {
    return DialogTheme(
        backgroundColor: _themeColor(AppColors.cardDark, AppColors.white),
        titleTextStyle: AppTextStyle.dialogTitle(context),
        contentTextStyle: AppTextStyle.bodyMedium(context));
  }

  /// Button style theme (e.g., ElevatedButton).
  ElevatedButtonThemeData _elevatedButtonTheme() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: AppColors.red,
          foregroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.r),
          ),
          textStyle: AppTextStyle.buttonTextStyle()),
    );
  }

  /// Style for tab bars (used in TabBar widget).
  TabBarTheme _tabBarTheme() {
    return TabBarTheme(
      labelStyle: AppTextStyle.buttonTextStyle(),
      unselectedLabelStyle: AppTextStyle.bodyMedium(context),
      labelColor: AppColors.white,
      unselectedLabelColor: isDark ? AppColors.white : AppColors.black,
      dividerColor: Colors.transparent,
      indicatorColor: Colors.transparent,
      indicatorSize: TabBarIndicatorSize.tab,
      tabAlignment: TabAlignment.start,
      indicator: BoxDecoration(
        borderRadius: BorderRadius.circular(5.r),
        color: AppColors.red,
      ),
    );
  }
}
