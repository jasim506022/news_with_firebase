import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:newsapps/res/app_colors.dart';
import 'package:newsapps/res/app_string.dart';

/// A utility class for checking network connectivity and handling no-internet scenarios.
class NetworkUtils {
  static final Connectivity _connectivity = Connectivity();

  /// Executes a function only if the internet is available, otherwise shows a snackbar.
  static Future<void> executeWithInternetCheck(
      {required VoidCallback action, required BuildContext context}) async {
    if (await _hasInternet()) {
      action();
    } else {
      _showNoInternetSnackbar(context);
    }
  }

  /// Checks if the device has an active internet connection.
  static Future<bool> _hasInternet() async {
    return await _connectivity.checkConnectivity() != ConnectivityResult.none;
  }

  /// Displays a snackbar when there is no internet.
  static void _showNoInternetSnackbar(BuildContext context) {
    var snackBar = SnackBar(
      margin: EdgeInsets.zero, // You can adjust this margin as needed
      duration: const Duration(seconds: 2),
      backgroundColor: AppColors.black.withOpacity(.7),
      behavior: SnackBarBehavior.floating, // Set the behavior to floating
      content: const Column(
        children: [
          Text(AppString.noInternet),
          Text(AppString.noInternetMessage),
        ],
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

/*
2️⃣ Improve executeWithInternetCheck()
✅ Issue: VoidCallback action does not support async functions (like API calls).
✅ Fix: Use Future<void> Function() instead of VoidCallback.
*/