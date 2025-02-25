import 'package:flutter/material.dart';
import 'package:newsapps/res/const.dart';

class OnboardingProvider with ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  PageController pageController = PageController(initialPage: 0);

  /// Update page index and notify listeners
  void updatePageIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  /// Move to next page
  void nextPage(BuildContext context) async {
    if (_currentIndex == 2) {
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
    // notifyListeners();
  }

  /// Save onboarding completion in SharedPreferences
  Future<void> completeOnboarding(BuildContext context) async {
    await sharedPreferences!.setInt("onBoard", 0);
    Navigator.pushReplacementNamed(context, "/LoginDetailsPage");
  }
}

/*
why use currenIndex Final;

*/


