import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:newsapps/res/const.dart';
import '../../model/bookmarksmodel.dart';
import '../other/database_service.dart';

class BookmarksProvider with ChangeNotifier {
  List<BookmarksModel> bookimarNewList = [];

  List<BookmarksModel> get getbookimarNewList {
    return bookimarNewList;
  }

  Future<List<BookmarksModel>> fetchAllNews() async {
    bookimarNewList = await DatabaseService.allBookmarks();
    return bookimarNewList;
  }

  Future delete({required String publishedAt}) async {
    final firebasedatabase = FirebaseFirestore.instance
        .collection("uses")
        .doc(sharedPreferences!.getString("uid"))
        .collection("news");
    firebasedatabase.doc(publishedAt).delete();
    await fetchAllNews();
    notifyListeners();
  }
}
