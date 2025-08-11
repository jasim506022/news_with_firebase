import 'package:flutter/material.dart';
import 'package:newsapps/res/app_string.dart';

import '../../res/app_routes.dart';
import '../../res/app_constant.dart';
import '../other/onbaording_data.dart';

class OnboardingProvider with ChangeNotifier {
  // Tracks the current onboarding page index.
  int _currentIndex = 0;
// Exposes the current page index.
  int get currentIndex => _currentIndex;

  // Controller for the onboarding PageView.
  final PageController pageController = PageController(initialPage: 0);

  /// Updates the current page index and notifies listeners to rebuild UI.
  void updatePageIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  /// Advances to the next onboarding page, or completes onboarding if on the last page.
  Future<void> nextPage(BuildContext context) async {
    if (_currentIndex == OnboardingDataList.onboardModeList.length - 1) {
      await completeOnboarding(context);
    } else {
      _currentIndex++;
      pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
      );
      notifyListeners();
    }
  }

  /// Marks onboarding as complete and navigates to the sign-in page.
  Future<void> completeOnboarding(BuildContext context) async {
// Save onboarding completion status in shared preferences.
    await AppConstants.sharedPreferences!
        .setBool(AppString.onboardSharePrefer, true);

    // Navigate and replace onboarding screen with the sign-in screen.
    if (!context.mounted) return;
    Navigator.pushReplacementNamed(context, AppRoutes.signInPage);
  }
}
