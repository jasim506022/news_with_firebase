import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/bookmarksmodel.dart';

class DatabaseService {
  static Future<List<BookmarksModel>> allBookmarks() async {
    final db = FirebaseFirestore.instance;
    final snapshot = await db.collection("News").get();
    final bookmarkData =
        snapshot.docs.map((e) => BookmarksModel.fromSnapshot(e)).toList();
    return bookmarkData;
  }

  static Future<bool> checkDocuement({required String docID}) async {
    final snapShot = await FirebaseFirestore.instance
        .collection('News')
        .doc(docID) // varuId in your case
        .get();
    return snapShot.exists;

    // return isbool;
  }
}
