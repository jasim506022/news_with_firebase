import 'package:flutter/material.dart';

import 'database_service.dart';

class IsBookmarkProvider with ChangeNotifier {
  bool _loading = false;

  bool get isLoading => _loading;

  setLoading({required bool isLoading}) {
    _loading = isLoading;
    notifyListeners();
  }

  bool _loadingphone = false;

  bool get isLoadingphone => _loadingphone;

  setLoadingphone({required bool isLoading}) {
    _loading = isLoading;
    notifyListeners();
  }

  bool _loadingGmail = false;

  bool get isLoadingGmail => _loadingGmail;

  setLoadingGmail({required bool isLoading}) {
    _loading = isLoading;
    notifyListeners();
  }

  bool isBookmark = false;

  bool get isbookmar => isBookmark;

  getbookmark({required String docID}) async {
    bool isCheck = await DatabaseService.checkDocuement(docID: docID);
    return isCheck;
  }

  Future<bool> setBookmarks({required bool isBook}) async {
    isBookmark = isBook;
    return isBookmark;
  }
}
