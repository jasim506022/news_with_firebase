import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../const/apiconst.dart';
import '../model/newsmodel.dart';

class ApiServices {
  static Future<List<NewsModel>> getAllTopNews(
      {required int pageSize, required String category}) async {
    try {
      var uri = Uri.https(BASEURL, "v2/top-headlines", {
        "country": "us",
        "pageSize": pageSize.toString(),
        "category": category,
        "page": "1"
      });

      var response = await http.get(uri, headers: {"X-Api-Key": API_KEY});
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

  static Future<List<NewsModel>> searchNewsItem({required String q}) async {
    try {
      var uri = Uri.https(BASEURL, "v2/top-headlines", {
        "q": q,
      });

      var response = await http.get(uri, headers: {"X-Api-Key": API_KEY});
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

  static Future<List<NewsModel>> getAllNews({required int page}) async {
    try {
      var uri = Uri.https(BASEURL, "v2/everything", {
        "q": "bitcoin",
        "pageSize": "10",
        "page": page.toString(),
      });

      var response = await http.get(uri, headers: {"X-Api-Key": API_KEY});
      Map data = jsonDecode(response.body);

      List tempList = [];

      for (var v in data['articles']) {
        tempList.add(v);
        // print(v);
      }
      return NewsModel.snapchatTopNewsList(tempList);
    } catch (error) {
      throw error.toString();
    }
  }

 
}


