import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class BookmarksModel with ChangeNotifier {
  final String? kid;
  final String id;
  final String source;
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String content;
  final String datetoshow;
  final String readingTimeText;

  BookmarksModel({
    this.kid,
    required this.id,
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
    required this.datetoshow,
    required this.readingTimeText,
  });

  

  

   factory BookmarksModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return BookmarksModel(
      kid: data['publishedAt'] ?? '',
      id: data['id'],
      source: data["source"] ?? '',
      author: data['author'] ?? '',
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      url: data['url'] ?? '',
      urlToImage: data['urlToImage'] ?? '',
      publishedAt: data['publishedAt'] ?? '',
      content: data['content'] ?? '',
      datetoshow: data['datetoshow'] ?? '',
      readingTimeText: data['readingTimeText'] ?? '',
    );
  }

}
