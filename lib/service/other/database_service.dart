import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:newsapps/res/app_constant.dart';
import 'package:newsapps/res/app_string.dart';

import '../../model/news_model_.dart';

class DatabaseService {
  static final db = FirebaseFirestore.instance;

  static updateBookmarks(
      {required String id, required NewsModel newsmodel}) async {
    await db
        .collection("uses")
        .doc(AppConstant.sharedPreferences!.getString(AppString.uidSharePrefer))
        .collection("news")
        .doc(id)
        .set(newsmodel.toMap());
  }

  static Future<List<NewsModel>> fetchAllBookmarks() async {
    final snapshot = await db
        .collection("uses")
        .doc(AppConstant.sharedPreferences!.getString("uid"))
        .collection("news")
        .get();
    final bookmarkData =
        snapshot.docs.map((e) => NewsModel.fromSnapshot(e)).toList();
    return bookmarkData;
  }

  static Future<void> deleteBookmark({required String publishedAt}) async {
    final firebasedatabase = FirebaseFirestore.instance
        .collection("uses")
        .doc(AppConstant.sharedPreferences!.getString("uid"))
        .collection("news");
    firebasedatabase.doc(publishedAt).delete();
  }

  static Future<void> clearAllBookmarks() async {
    try {
      final bookmarksRef = FirebaseFirestore.instance
          .collection('uses')
          .doc(AppConstant.sharedPreferences!.getString("uid"))
          .collection("news");

      final snapshot = await bookmarksRef.get();
      final batch = FirebaseFirestore.instance.batch();
      for (final doc in snapshot.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();
    } catch (e) {
      debugPrint("🔥 Error clearing Firestore bookmarks: $e");
    }
  }
}
