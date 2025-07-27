import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newsapps/model/news_model_.dart';

import '../../res/app_constant.dart';
import '../../res/app_function.dart';
import '../other/database_service.dart';

class BookmarksProvider with ChangeNotifier {
  List<NewsModel> bookimarNewList = [];

  List<NewsModel> get getbookimarNewList {
    return bookimarNewList;
  }

  Future<List<NewsModel>> fetchAllNews() async {
    bookimarNewList = await DatabaseService.allBookmarks();
    return bookimarNewList;
  }

  bool isBookmarked(String publishedAt) {
    return bookimarNewList.any((item) => item.publishedAt == publishedAt);
  }

  Future delete({required String publishedAt}) async {
    final firebasedatabase = FirebaseFirestore.instance
        .collection("uses")
        .doc(AppConstant.sharedPreferences!.getString("uid"))
        .collection("news");
    firebasedatabase.doc(publishedAt).delete();
    await fetchAllNews();
    notifyListeners();
  }

  Future<void> toggleBookmark({required dynamic newsModel}) async {
    final isAlreadyBookmarked = isBookmarked(newsModel.publishedAt);

    if (isAlreadyBookmarked) {
      await delete(publishedAt: newsModel.publishedAt);
      AppFunction.toastMessage("Removed from Bookmarks");
    } else {
      await DatabaseService.uploadFirebase(
          id: newsModel.publishedAt, newsmodel: newsModel);
      AppFunction.toastMessage("Added to Bookmarks");
    }

    await fetchAllNews(); // refresh state
    notifyListeners();
  }

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

      bookimarNewList.clear(); // clear in-memory list
      notifyListeners();
    } catch (e) {
      debugPrint("🔥 Error clearing Firestore bookmarks: $e");
    }
  }
}
