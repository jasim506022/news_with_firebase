import 'package:flutter/material.dart';

/// Provider class to manage WebView loading progress and loading state
class WebViewProgressProvider extends ChangeNotifier {
  double _progress = 0.0;

  double get progress => _progress;

  /// Set loading progress [value] between 0.0 and 1.0
  void setProgress(double value) {
    _progress = value;
    notifyListeners();
  }
}
