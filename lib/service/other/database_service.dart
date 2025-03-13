import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newsapps/res/const.dart';

import '../../model/bookmarksmodel.dart';
import '../../model/news_model_.dart';

class DatabaseService {
  static final db = FirebaseFirestore.instance;

  static uploadFirebase(
      {required String id, required NewsModel newsmodel}) async {
    await db
        .collection("uses")
        .doc(sharedPreferences!.getString("uid"))
        .collection("news")
        .doc(id)
        .set(newsmodel.toMap());
  }

  static Future<List<BookmarksModel>> allBookmarks() async {
    final snapshot = await db
        .collection("uses")
        .doc(sharedPreferences!.getString("uid"))
        .collection("news")
        .get();
    final bookmarkData =
        snapshot.docs.map((e) => BookmarksModel.fromSnapshot(e)).toList();
    return bookmarkData;
  }
}
