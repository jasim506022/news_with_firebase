import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../res/app_colors.dart';
import '../res/app_text_style.dart';

/// This widget is useful for login, registration, or any text input field that requires custom styling.
class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField(
      {super.key,
      required this.hintText,
      required this.controller,
      this.autofocus = false,
      this.obscureText = false,
      this.hasPasswordToggle = false,
      this.textInputAction = TextInputAction.next,
      this.maxLines = 1,
      this.enabled = true,
      this.textInputType = TextInputType.text,
      this.onChanged,
      this.validator,
      this.decoration,
      this.label,
      this.maxLength,
      this.style});
  final String hintText;
  final TextEditingController controller;
  final bool autofocus;
  final TextInputAction? textInputAction;
  final TextInputType textInputType;
  final int? maxLines;
  final bool obscureText;
  final bool hasPasswordToggle;
  final bool enabled;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;

  final InputDecoration? decoration;
  final TextStyle? style;

  final String? label;
  final int? maxLength;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  /// Controls password visibility when `hasPasswordToggle` is enabled.
  late bool _obscureText;
  @override
  void initState() {
    /// Initializes `_obscureText` based on the widget's `obscureText` property.
    _obscureText = widget.obscureText;
    super.initState();
  }

  /// Toggles the visibility of password text.

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.label != null
          ? EdgeInsets.symmetric(vertical: 10.h)
          : EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Displays the label if provided.
          if (widget.label != null)
            Text(widget.label!, style: AppTextStyle.label(context)),

          /// Adds spacing between label and input field.
          if (widget.label != null)
            SizedBox(
              height: 8.h,
            ),

          TextFormField(
            onChanged: widget.onChanged,
            enabled: widget.enabled,
            controller: widget.controller,
            autofocus: widget.autofocus,
            maxLines: widget.maxLines,
            validator: widget.validator,
            obscureText: _obscureText,
            maxLength: widget.maxLength,
            textInputAction: widget.textInputAction,
            keyboardType: widget.textInputType,
            style: widget.style ?? AppTextStyle.inputText(widget.enabled),

            /// Applies the provided decoration or uses default styling.
            decoration: AppsFunction.textFieldInputDecoration(
                isEnable: widget.enabled,
                hintText: widget.hintText,
                isShowPassword: widget.hasPasswordToggle,
                obscureText: _obscureText,
                onPasswordToggle: widget.hasPasswordToggle
                    ? _togglePasswordVisibility
                    : null),
          ),
        ],
      ),
    );
  }
}

class AppsFunction {
  /// This function provides a pre-defined text field decoration with options for:
  static InputDecoration textFieldInputDecoration(
      {bool isShowPassword = false,
      required String hintText,
      bool obscureText = false,
      bool isEnable = true,
      VoidCallback? onPasswordToggle}) {
    // ✅ More specific type}
    return InputDecoration(
        // Background color changes based on enabled state

        fillColor: isEnable
            ? AppColors.searchLightColor
            : AppColors
                .red, //AppColors.searchLightColor : ThemeUtils.textFieldColor,
        filled: true,
        hintText: hintText,
        // Border styling: No border, rounded corners
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(15.r)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(15.r)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(15.r)),
        // Adds password visibility toggle if needed
        suffixIcon: isShowPassword
            ? IconButton(
                onPressed: onPasswordToggle ?? () {}, // ✅ Safe null handling,
                icon: Icon(
                  obscureText ? Icons.visibility_off : Icons.visibility,
                  color: obscureText ? AppColors.black : AppColors.red,
                ))
            : null,
        contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
        hintStyle: AppTextStyle.hintText);
  }
}
