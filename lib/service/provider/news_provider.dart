import 'package:flutter/foundation.dart';

import '../../model/news_model_.dart';
import '../other/api_service.dart';

class NewsProvider with ChangeNotifier {
  List<NewsModel> _newsList = [];

  /// Fetches top news from the API for the given page.
  ///
  /// Throws an exception if an error occurs during fetch.
  Future<List<NewsModel>> fetchTopNews({required int page}) async {
    try {
      return await ApiServices.fetchTopNews(page: page);
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print(stackTrace);
      }
      // Optional: You can log `stackTrace` for deeper debugging in development
      throw Exception('Failed to fetch top news: $e');
    }
  }

  /// Fetches news articles by category using the API service.
  /// Updates the local news list and returns the fetched result.
  Future<List<NewsModel>> fetchNewsByCategory({
    required String category,
    required int pageSize,
  }) async {
    try {
      _newsList = await ApiServices.fetchNewsByCategory(
        category: category,
        pageSize: pageSize,
      );
      return _newsList;
    } catch (e) {
      // Log or handle API errors
      throw Exception('Failed to fetch category news: $e');
    }
  }

  Future<void> loadNews() async {
    final result = await ApiServices.fetchTopNews(page: 1);
    totalPages =
        result.length; // from "news" key in the Map returned by the API
    notifyListeners();
  }

  List<NewsModel> get newsList => _newsList;

  int _currentindex = 0;

  bool _isSearch = false;

  bool get isSearch => _isSearch;

  int totalPages = 1;

  void setSearch(bool isSearch) {
    _isSearch = isSearch;
    notifyListeners();
  }

  int get currentindex => _currentindex;

  void setCurrentIndex(int index) {
    _currentindex = index;
    notifyListeners();
  }

  addCurrentIndex() {
    _currentindex++;
    notifyListeners();
  }

  removeCurrentIndex() {
    _currentindex--;
    notifyListeners();
  }

  List<NewsModel> get getNewsList {
    return _newsList;
  }
}
