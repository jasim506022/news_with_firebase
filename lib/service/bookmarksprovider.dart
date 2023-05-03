import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../model/bookmarksmodel.dart';
import 'database_service.dart';

class BookmarksProvider with ChangeNotifier {
  List<BookmarksModel> newsList = [];

  List<BookmarksModel> get getNewsList {
    return newsList;
  }

  Future<List<BookmarksModel>> fetchAllNews() async {
    newsList = await DatabaseService.allBookmarks();
    //notifyListeners();
    return newsList;
  }

  Future delete({required String publishedAt}) async {
    final firebasedatabase = FirebaseFirestore.instance.collection('News');
    firebasedatabase.doc(publishedAt).delete();
    await fetchAllNews();
    notifyListeners();
  }
}
