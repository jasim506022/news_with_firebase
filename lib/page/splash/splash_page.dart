import 'package:flutter/material.dart';
import 'package:newsapps/service/provider/splash_provider.dart';
import 'package:provider/provider.dart';

import '../../res/app_colors.dart';
import '../../widget/app_logo_widget.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SplashProvider>(builder: (context, splashProvider, child) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        splashProvider.isMainPages(context); // ✅ Called after widget builds
      });

      return Scaffold(
        body: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
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