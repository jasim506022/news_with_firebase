import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newsapps/res/app_constant.dart';

import '../../model/bookmarks_model.dart';
import '../../model/news_model_.dart';

class DatabaseService {
  static final db = FirebaseFirestore.instance;

  static uploadFirebase(
      {required String id, required NewsModel newsmodel}) async {
    await db
        .collection("uses")
        .doc("KOxquftZOGTeY2d6wxmjMzJkUtj1")
        .collection("news")
        .doc(id)
        .set(newsmodel.toMap());
  }

  static Future<List<BookmarksModel>> allBookmarks() async {
    final snapshot = await db
        .collection("uses")
        .doc(AppConstant.sharedPreferences!.getString("uid"))
        .collection("news")
        .get();
    final bookmarkData =
        snapshot.docs.map((e) => BookmarksModel.fromSnapshot(e)).toList();
    return bookmarkData;
  }
}
