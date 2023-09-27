import 'package:flutter/foundation.dart';

class LoadingProvider with ChangeNotifier {
  bool _loading = false;

  bool get isLoading => _loading;

  setUploading({required bool loading}) {
    _loading = loading;
    notifyListeners();
  }

  bool _loadingIcon = false;

  bool get isLoadinggmail => _loadingIcon;

  setLoadingGmail({required bool loading}) {
    _loadingIcon = loading;
    notifyListeners();
  }
}
