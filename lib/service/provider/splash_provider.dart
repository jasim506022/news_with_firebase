import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../page/auth/log_in_page.dart';
import '../../page/home/home_page.dart';
import '../../page/splash/onboading_page.dart';
import '../../res/app_constant.dart';

class SplashProvider with ChangeNotifier {
  final auth = FirebaseAuth.instance;

  void isMainPages(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      var route = auth.currentUser != null
          ? const HomePage()
          : AppConstants.isOnboardingViewed == 0
              ? const OnboardingPage()
              : const LoginPage();

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => route,
          ));
    });
  }
}
