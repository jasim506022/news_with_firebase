import 'package:flutter/foundation.dart';

import '../../model/news_model_.dart';
import '../other/api_service.dart';

class NewsProvider with ChangeNotifier {
  List<NewsModel> _newsList = [];

  bool _isLoading = false;
  bool _isEndReached = false;
  int _limit = 10;

  List<NewsModel> get newsList => _newsList;
  bool get isLoading => _isLoading;
  bool get isEndReached => _isEndReached;

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

  Future<void> fetchNewsByCategorya({
    required String category,
    bool isLoadMore = false,
  }) async {
    if (_isLoading || _isEndReached) return;

    _isLoading = true;
    notifyListeners();

    try {
      if (isLoadMore) _limit += 10;

      final fetched = await ApiServices.fetchNewsByCategory(
        pageSize: _limit,
        category: category.toLowerCase(),
      );

      _newsList = fetched;
      _isEndReached = fetched.length < _limit;
    } catch (e) {
      rethrow;
    }

    _isLoading = false;
    notifyListeners();
  }

  void reset() {
    _limit = 10;
    _newsList = [];
    _isEndReached = false;
    _isLoading = false;
  }

  // Future<void> loadNews() async {
  //   final result = await ApiServices.fetchTopNews(page: 1);
  //   totalPages =
  //       result.length; // from "news" key in the Map returned by the API
  //   notifyListeners();
  // }

  /// Index of the current page being viewed.
  int _currentIndex = 0;

  /// Getter for [_currentIndex].
  int get currentindex => _currentIndex;

  /// Sets the current index to [index] and notifies listeners.
  void setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  /// Increments the current index by 1 and notifies listeners.

  void addCurrentIndex() {
    _currentIndex++;
    notifyListeners();
  }

  /// Decrements the current index by 1 and notifies listeners.
  removeCurrentIndex() {
    _currentIndex--;
    notifyListeners();
  }
}
