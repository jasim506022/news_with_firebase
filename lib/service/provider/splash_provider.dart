import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../res/app_constant.dart';
import '../../res/app_routes.dart';

class SplashProvider with ChangeNotifier {
  final _auth = FirebaseAuth.instance;

  /// Navigate to the appropriate next screen after splash delay.
  ///
  /// Checks if user is logged in, onboarding viewed, then navigates accordingly.
  Future<void> navigateToNextScreen(BuildContext context) async {
    // Wait 2 seconds to show splash screen.
    await Future.delayed(const Duration(seconds: 2));

    // Decide which page to navigate to next.
    final bool isLoggedIn = _auth.currentUser != null;
    final bool isOnboardingViewed = AppConstants.isOnboardingViewed;

    String nextRouteName;

    if (isLoggedIn) {
      nextRouteName = AppRoutes.homePage;
    } else if (!isOnboardingViewed) {
      nextRouteName = AppRoutes.onboardingPage;
    } else {
      nextRouteName = AppRoutes.signInPage;
    }

    // Navigate by route name to ensure proper navigation stack management.
    if (!context.mounted) return;
    Navigator.pushReplacementNamed(context, nextRouteName);
  }
}
