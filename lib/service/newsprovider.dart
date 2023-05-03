import 'package:flutter/material.dart';
import 'package:newsapps/service/apiservice.dart';

import '../model/newsmodel.dart';

class NewsProvider with ChangeNotifier {
  List<NewsModel> newsList = [];
  int _currentindex = 0;

  bool _isSearch = false;

  bool get isSearch => _isSearch;

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
    return newsList;
  }

  Future<List<NewsModel>> fetchAllNews({required int page}) async {
    newsList = await ApiServices.getAllNews(page: page);
    return newsList;
  }

  Future<List<NewsModel>> fetchAllTopNews(
      {required String category, required int pageSize}) async {
    newsList =
        await ApiServices.getAllTopNews(category: category, pageSize: pageSize);
    return newsList;
  }

  Future<List<NewsModel>> fetchASearchNews({
    required String q,
  }) async {
    newsList = await ApiServices.searchNewsItem(q: q);
    return newsList;
  }

NewsModel findByDate({required String? publishedAt}) {
    return newsList
        .firstWhere((newsModel) => newsModel.publishedAt == publishedAt);
  }
}
