import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsapps/res/app_function.dart';

import '../res/app_colors.dart';
import '../res/app_string.dart';
import 'outline_text_button_widget.dart';

/// A customizable confirmation dialog used for actions like logout, delete, exit, etc.
///
/// Includes title, icon, content text, and YES/NO buttons with customizable actions
class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog(
      {super.key,
      required this.dialogTitle,
      required this.dialogIcon,
      required this.message,
      this.onCancel,
      required this.onConfirm});

  final String dialogTitle;
  final IconData dialogIcon;
  final String message;
  final VoidCallback? onCancel;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(children: [
        // Dialog title with icon
        Text(dialogTitle),
        AppFunction.horizontalSpace(10),
        Container(
            padding: EdgeInsets.all(5.r),
            decoration:
                BoxDecoration(color: AppColors.red, shape: BoxShape.circle),
            child: Icon(dialogIcon, color: AppColors.white))
      ]),
      // Dialog message/content
      content: Text(message),
      // Dialog action buttons (YES / NO)
      actions: <Widget>[
        OutlinedTextButtonWidget(
            color: Colors.green, title: AppString.btnYes, onPressed: onConfirm),
        OutlinedTextButtonWidget(
            color: AppColors.red,
            title: AppString.btnNo,
            onPressed: onCancel ?? () => Navigator.of(context).pop())
      ],
    );
  }
}
