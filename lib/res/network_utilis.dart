import 'dart:io';

import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'app_colors.dart';
import 'app_string.dart';

/// A utility class for checking network connectivity and handling no-internet scenarios.
class NetworkUtils {
  static final Connectivity _connectivity = Connectivity();

  /// Executes a function only if the internet is available, otherwise shows a snackbar.
  static Future<void> executeWithInternetCheck(
      {required VoidCallback action, required BuildContext context}) async {
    if (await _hasInternet()) {
      action(); // Why use ()
    } else {
      if (!context.mounted) return;
      _showNoInternetSnackbar(context);
    }
  }

  /// Checks if the device has an active internet connection.
  static Future<bool> _hasInternet() async {
    final connectivityResult = await _connectivity.checkConnectivity();
    // ignore: unrelated_type_equality_checks
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    }
    // Optional: Test if you can reach the internet (e.g., ping Google)
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  /// Displays a snackbar when there is no internet.
  static void _showNoInternetSnackbar(BuildContext context) {
    var snackBar = SnackBar(
      margin: EdgeInsets.zero, // You can adjust this margin as needed
      duration: const Duration(seconds: 2),
      backgroundColor: AppColors.black.withOpacity(.7),
      behavior: SnackBarBehavior.floating, // Set the behavior to floating
      content: const SizedBox(
        height: 50, // set a height to prevent overflow
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppString.noInternet,
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text(AppString.noInternetMessage),
          ],
        ),
      ),
    );
    // ScaffoldMessenger.of(context).showSnackBar(snackBar);
    final messenger = ScaffoldMessenger.maybeOf(context);
    if (messenger != null) {
      messenger.showSnackBar(snackBar);
    } else {
      debugPrint('No ScaffoldMessenger found in the context');
    }
  }
}

/*
2️⃣ Improve executeWithInternetCheck()
✅ Issue: VoidCallback action does not support async functions (like API calls).
✅ Fix: Use Future<void> Function() instead of VoidCallback.
When i use function(), and when use funtion()
*/