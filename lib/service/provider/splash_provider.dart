import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../page/auth/loginpage.dart';
import '../../page/splash/onboading_page.dart';
import '../../page/news/homepage.dart';
import '../../res/const.dart';

class SplashProvider with ChangeNotifier {
  final auth = FirebaseAuth.instance;

  void isMainPages(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      var route = auth.currentUser != null
          ? const HomePage()
          : isViewd != 0
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
