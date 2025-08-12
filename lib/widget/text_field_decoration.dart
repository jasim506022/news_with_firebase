import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../res/app_colors.dart';
import '../res/app_text_style.dart';

/// Provides input decoration for text fields with optional password toggle..
class TextFieldDecoration {
// Reusable border style to avoid repetition
  static InputBorder _defaultBorder([Color? borderColor]) => OutlineInputBorder(
        borderSide: BorderSide(color: borderColor ?? AppColors.grey, width: 1),
        borderRadius: BorderRadius.circular(15.r),
      );

  /// Returns pre-defined InputDecoration with options:
  /// - show/hide password toggle
  /// - hint text
  /// - obscure text mode
  /// - enable/disable field
  /// - callback for password visibility toggle
  static InputDecoration inputDecoration({
    bool isShowPassword = false,
    required String hintText,
    bool isPasswordObscured = false,
    bool isEnable = true,
    VoidCallback? onPasswordToggle,
  }) {
    return InputDecoration(
        fillColor: isEnable ? AppColors.white : AppColors.red,
        filled: true,
        hintText: hintText,
        enabledBorder: _defaultBorder(),
        focusedBorder: _defaultBorder(),
        disabledBorder: _defaultBorder(AppColors.black),
        errorBorder: _defaultBorder(AppColors.red),
        focusedErrorBorder: _defaultBorder(AppColors.red),
        suffixIcon: isShowPassword
            ? IconButton(
                onPressed: onPasswordToggle ?? () {},
                icon: Icon(
                  isPasswordObscured ? Icons.visibility_off : Icons.visibility,
                  color: isPasswordObscured ? AppColors.black : AppColors.red,
                ))
            : null,
        contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
        hintStyle: AppTextStyle.hintText);
  }
}
