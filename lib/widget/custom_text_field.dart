import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../res/app_function.dart';
import '../res/app_text_style.dart';
import 'text_field_decoration.dart';

/// This widget is useful for login, registration, or any text input field that requires custom styling.
class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
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
    this.style,
  });
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
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  /// Controls password visibility when `hasPasswordToggle` is enabled.
  late bool _obscureText;

  @override
  void initState() {
    /// Initializes `_obscureText` based on the widget's `obscureText` property.
    _obscureText = widget.obscureText;
    super.initState();
  }

  /// Toggles the visibility of password text.
  void _togglePasswordVisibility() =>
      setState(() => _obscureText = !_obscureText);

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
          if (widget.label != null) AppFunction.verticalSpace(8),

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
            decoration: TextFieldDecoration.inputDecoration(
                isEnable: widget.enabled,
                hintText: widget.hintText,
                isShowPassword: widget.hasPasswordToggle,
                isPasswordObscured: _obscureText,
                onPasswordToggle: widget.hasPasswordToggle
                    ? _togglePasswordVisibility
                    : null),
          ),
        ],
      ),
    );
  }
}
