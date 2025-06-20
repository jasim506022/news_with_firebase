import 'package:flutter/material.dart';

import '../../model/news_model_.dart';
import '../other/api_service.dart';

class NewsProvider with ChangeNotifier {
  // Add Try Catch Example
  // Okay

  Future<List<NewsModel>> fetchAllTopNews({required int page}) async {
    try {
      return await ApiServices.fetchAllTopNews(page: page);
    } catch (e) {
      throw Exception("Error fetching news: $e");
    }
  }

  Future<void> loadNews() async {
    final result = await ApiServices.fetchAllTopNews(page: 1);
    totalPages =
        result.length; // from "news" key in the Map returned by the API
    notifyListeners();
  }

  List<NewsModel> _newsList = [];

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

  Future<List<NewsModel>> fetchAllNews(
      {required String category, required int pageSize}) async {
    _newsList =
        await ApiServices.getAllNews(category: category, pageSize: pageSize);
    return _newsList;
  }

  Future<List<NewsModel>> fetchASearchNews({
    required String q,
  }) async {
    _newsList = await ApiServices.searchNewsItem(q: q);
    return _newsList;
  }
}
