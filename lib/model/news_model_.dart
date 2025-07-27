import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:newsapps/res/app_constant.dart';
import 'package:reading_time/reading_time.dart';

class NewsModel with ChangeNotifier {
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

  NewsModel({
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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'source': source,
      'author': author,
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt,
      'content': content,
      'datetoshow': datetoshow,
      'readingTimeText': readingTimeText,
    };
  }

  factory NewsModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return NewsModel(
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

  factory NewsModel.fromMap(Map<String, dynamic> map) {
    String title = map['title'] ?? '';
    String description = map['description'] ?? '';
    String content = map['title'] ?? '';
    String datetoshow = "";
    if (map['publishedAt'] != null) {
      datetoshow = globalMethod.formattedDatText(map['publishedAt'] ?? '');
    }
    return NewsModel(
      id: map["source"]['id'] ?? '',
      source: map["source"]["name"] ?? '',
      author: map['author'] ?? '',
      title: title,
      description: description,
      url: map['url'] ?? '',
      urlToImage: map['urlToImage'] ?? '',
      publishedAt: map['publishedAt'] ?? '',
      content: content,
      datetoshow: datetoshow,
      readingTimeText: readingTime(title + description + content).msg,
    );
  }

  static List<NewsModel> snapchatTopNewsList(List<dynamic> topNewsList) {
    return topNewsList.map((e) => NewsModel.fromMap(e)).toList();
  }
}




/*

1.  factory NewsModel.fromMap(Map<String, dynamic> map) {
between
 factory BookmarksModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document)




1. where why need notifi change
*/

/*
Great question.

You're asking for the difference between:

dart
Copy
Edit
factory NewsModel.fromMap(Map<String, dynamic> map)
and

dart
Copy
Edit
factory BookmarksModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document)
*/