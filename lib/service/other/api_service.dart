import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:newsapps/res/app_function.dart';
import 'package:newsapps/res/app_routes.dart';
import 'package:newsapps/res/app_constant.dart';
import 'package:newsapps/service/provider/bookmarks_provider.dart';
import 'package:provider/provider.dart';
import '../../res/app_text_style.dart';
import '../../res/app_colors.dart';
import '../../model/news_model_.dart';

class ApiServices {
  static final firebaseAuth = FirebaseAuth.instance;
  static final firebaseFirestore = FirebaseFirestore.instance;

  /// Fetches top news articles from the News API.
  ///
  /// Throws an [Exception] if the request fails or if parsing fails.
  static Future<List<NewsModel>> fetchTopNews({required int page}) async {
    final uri = Uri.https(AppConstants.baseurl, "v2/everything", {
      "q": "bitcoin",
      "pageSize": "10",
      "page": page.toString(),
    });

    try {
      try {
        final response = await http.get(uri, headers: {"X-Api-Key": apiKey});
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          List articles = data['articles'];
          return articles.map((e) => NewsModel.fromMap(e)).toList();
        } else {
          throw Exception("Failed to load news");
        }
      } catch (e) {
        throw Exception("Error fetching news: $e");
      }
    } catch (error) {
      throw error.toString();
    }
  }

  /// Fetches news articles from a specific category using the News API.
  static Future<List<NewsModel>> fetchNewsByCategory(
      {required int pageSize, required String category}) async {
    try {
      var uri = Uri.https(AppConstants.baseurl, "v2/top-headlines", {
        "country": "us",
        "pageSize": pageSize.toString(),
        "category": category,
        "page": "1"
      });

      var response = await http.get(uri, headers: {"X-Api-Key": apiKey});
      Map data = jsonDecode(response.body);

      List tempList = [];

      if (data['code'] != null) {
        throw HttpException(data['code']);
      }
      for (var v in data['articles']) {
        tempList.add(v);
      }
      return NewsModel.snapchatTopNewsList(tempList);
    } catch (error) {
      throw error.toString();
    }
  }

  // Okay
  static Future<List<NewsModel>> totalPage({required int page}) async {
    try {
      var uri = Uri.https(AppConstants.baseurl, "v2/everything", {
        "q": "bitcoin",
        // "pageSize": "10",
        "page": page.toString(),
      });

      try {
        final response = await http.get(uri, headers: {"X-Api-Key": apiKey});
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          List articles = data['articles'];
          return articles.map((e) => NewsModel.fromMap(e)).toList();
        } else {
          throw Exception("Failed to load news");
        }
      } catch (e) {
        throw Exception("Error fetching news: $e");
      }
    } catch (error) {
      throw error.toString();
    }
  }

  /// Fetches news articles matching the search query [query].
  ///
  /// Sends an HTTP GET request to the news API's `top-headlines` endpoint,
  /// including the search parameter. Returns a list of [NewsModel].
  ///
  /// Throws a [String] with the error message if the request or parsing fails.

  static Future<List<NewsModel>> fetchNewsByQuery({required String q}) async {
    try {
      final uri = Uri.https(AppConstants.baseurl, "v2/top-headlines", {"q": q});
      // Perform the GET request with the API key in headers
      var response = await http
          .get(uri, headers: {"X-Api-Key": apiKey}); // use final not use var
      // Decode the JSON response body
      final Map<String, dynamic> responseData = jsonDecode(response.body);
// Extract the articles list; use empty list fallback to avoid null errors
      final List<dynamic> articlesJson = responseData['articles'] ?? [];

      // Map JSON articles to a list of NewsModel objects
      final List<NewsModel> articles =
          NewsModel.snapchatTopNewsList(articlesJson);
      return articles;
    } catch (error) {
      throw error.toString();
    }
  }

  static Future<void> logOutDialog(
      {required BuildContext context, bool isDelete = false, String? id}) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: isDelete == true
              ? Row(
                  children: [
                    const Text('Delete'),
                    Icon(
                      Icons.delete,
                      color: AppColors.red,
                    ),
                  ],
                )
              : const Text('Logout'),
          content: isDelete == true
              ? const Text('Are you want to Delete this Bookmarks Item')
              : const Text('Are you want to login in this App'),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.red,
                textStyle: AppTextStyle.buttonTextStyle(),
              ),
              child: const Text('Yes'),
              onPressed: () {
                isDelete == true
                    ? deletebooks(id!, context)
                    : firebaseAuth.signOut().then((value) {
                        Navigator.pushNamed(context, AppRoutes.signInPage);
                        AppFunction.toastMessage("Logout Sucessfully");
                      }).onError((error, stackTrace) {});
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                  foregroundColor: AppColors.red,
                  textStyle: AppTextStyle.buttonTextStyle()),
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static deletebooks(String id, BuildContext context) {
    final newsProvider = Provider.of<BookmarksProvider>(context, listen: false);
    newsProvider.deleteBookmark(publishedAt: id);
    AppFunction.toastMessage("Delete Sucessfully");
    Navigator.pop(context);
  }
}


/*
Search Defference
static Future<List<NewsModel>> searchNewsItem({required String q}) async {
    try {
      var uri = Uri.https(AppConstant.baseurl, "v2/top-headlines", {
        "q": q,
      });

      var response = await http.get(uri, headers: {"X-Api-Key": apiKey});
      Map data = jsonDecode(response.body);

      List tempList = [];

      for (var v in data['articles']) {
        tempList.add(v);
      }
      return NewsModel.snapchatTopNewsList(tempList);
    } catch (error) {
      throw error.toString();
    }
  }
*/