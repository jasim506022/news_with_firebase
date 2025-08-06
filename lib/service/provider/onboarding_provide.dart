import 'package:flutter/material.dart';
import 'package:newsapps/res/app_string.dart';

import '../../res/app_routes.dart';
import '../../res/app_constant.dart';
import '../other/onbaording_data.dart';

class OnboardingProvider with ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  PageController pageController = PageController(initialPage: 0);

  /// Update the current page index and notify listeners
  void updatePageIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  /// Move to the next page, or finish onboarding if it's the last page
  void nextPage(BuildContext context) async {
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

  /// Complete onboarding: save status and navigate to login page
  Future<void> completeOnboarding(BuildContext context) async {
    Navigator.pushReplacementNamed(context, AppRoutes.signInPage);
    await AppConstants.sharedPreferences!
        .setInt(AppString.onboardSharePrefer, 1);
  }
}
