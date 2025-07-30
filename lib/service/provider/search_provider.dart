import 'package:flutter/material.dart';

import '../../model/news_model_.dart';
import '../other/api_service.dart';

class SearchProvider with ChangeNotifier {
  //true if a search has been performed
  List<NewsModel> _searchResults = [];
  bool _hasSearched = false;

  List<NewsModel> get searchResults => _searchResults;

  bool get hasSearched => _hasSearched;

  /// Sets the search status flag and notifies listeners to update UI.
  void setSearch(bool value) {
    _hasSearched = value;
    notifyListeners();
  }

  /// Clears the current search results and resets the search status.
  void clearSearchResults() {
    _searchResults.clear();
    _hasSearched = false;
    notifyListeners();
  }

  /// Fetches a list of news articles matching the search query.
  ///
  /// This method calls the API service to retrieve news items based on
  /// the provided search keyword [query]. The internal `_searchResults`
  /// list is updated accordingly.
  ///
  /// Returns a [Future] containing the list of matching [NewsModel] objects.
  Future<void> searchNewsByQuery({
    required String query,
  }) async {
    try {
      _searchResults = await ApiServices.fetchNewsByQuery(q: query);
    } catch (e) {
      rethrow;
    }
  }
}
