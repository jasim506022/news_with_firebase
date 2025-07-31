import 'package:flutter/material.dart';

import '../../model/news_model_.dart';
import '../../res/app_function.dart';
import '../../res/app_string.dart';
import '../other/database_service.dart';

class BookmarksProvider with ChangeNotifier {
  /// In-memory list of all bookmarked news
  List<NewsModel> _bookmarkedNews = [];

  /// Public getter for bookmarked news
  List<NewsModel> get bookmarkedNews {
    return _bookmarkedNews;
  }

  /// Fetch all bookmarks from Firestore

  Future<List<NewsModel>> fetchAllBookmarks() async {
    _bookmarkedNews = await DatabaseService.fetchAllBookmarks();
    return _bookmarkedNews;
  }

  /// Check if a news item is bookmarked by its published date
  bool isBookmarked(String publishedAt) {
    return _bookmarkedNews.any((item) => item.publishedAt == publishedAt);
  }

  /// Delete a single bookmark by its published date
  Future deleteBookmark({required String publishedAt}) async {
    DatabaseService.deleteBookmark(publishedAt: publishedAt);
    await fetchAllBookmarks();
    notifyListeners();
  }

  /// Toggle bookmark status (add or remove)
  Future<void> toggleBookmark({required dynamic newsModel}) async {
    final isAlreadyBookmarked = isBookmarked(newsModel.publishedAt);

    if (isAlreadyBookmarked) {
      await deleteBookmark(publishedAt: newsModel.publishedAt);
      AppFunction.toastMessage(AppString.kRemovedFromBookmarks);
    } else {
      await DatabaseService.updateBookmarks(
          id: newsModel.publishedAt, newsmodel: newsModel);
      AppFunction.toastMessage(AppString.kAddedtoBookmarks);
    }
    await fetchAllBookmarks(); // refresh state
    notifyListeners();
  }

  // / 🔥 Delete all bookmarks from Firestore
  Future<void> clearAllBookmarks() async {
    try {
      DatabaseService.clearAllBookmarks();
      _bookmarkedNews.clear(); // clear in-memory list
      notifyListeners();
    } catch (e) {
      debugPrint("🔥 Error clearing Firestore bookmarks: $e");
    }
  }

/*
  /// 🔥 Delete all bookmarks from Firestore
  Future<void> clearAllBookmarks() async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) return;

      final bookmarksRef = FirebaseFirestore.instance
          .collection('uses')
          .doc(userId)
          .collection("news");

      final snapshot = await bookmarksRef.get();

      final batch = FirebaseFirestore.instance.batch();
      for (final doc in snapshot.docs) {
        batch.delete(doc.reference);
      }

      await batch.commit();

      _bookmarkedNews.clear(); // clear in-memory list
      notifyListeners();
    } catch (e) {
      debugPrint("🔥 Error clearing Firestore bookmarks: $e");
    }
  }
*/
}
