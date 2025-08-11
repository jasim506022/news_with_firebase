import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../res/app_colors.dart';
import '../../service/provider/splash_provider.dart';
import '../../widget/app_logo_widget.dart';

/// SplashPage displays the app logo and handles navigation to main pages after splash.
///
/// Uses SplashProvider to determine the next screen.
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SplashProvider>(builder: (context, splashProvider, _) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        splashProvider.navigateToNextScreen(context);
      });

      return Scaffold(
        body: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.r),
              color: AppColors.white,
            ),
            child: const AppLogoWidget(),
          ),
        ),
      );
    });
  }
}

/*
1. Understand Provider
2. WidgetBinding.instanc.AddPostFramCAllBack()
*/