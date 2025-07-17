import 'package:flutter/material.dart';

import '../../../res/app_colors.dart';
import '../../../res/app_function.dart';
import '../../../res/app_text_style.dart';
import '../../../widget/app_logo_widget.dart';

/// Drawer header widget displaying the app logo,
/// user name, and email with a dropdown icon.
class DrawerHeaderWidget extends StatelessWidget {
  const DrawerHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const AppLogoWidget(),
          AppFunction.verticalSpace(10),
          Text("Jasim Uddin", style: AppTextStyle.titleTextStyle(context)),
          AppFunction.verticalSpace(2),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("jasimrony50@gmail.com",
                  style: AppTextStyle.mediumBoldTextStyle(context)),
              Icon(Icons.arrow_drop_down, color: AppColors.black),
            ],
          ),
        ],
      ),
    );
  }
}
