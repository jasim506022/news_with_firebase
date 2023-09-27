import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:newsapps/const/const.dart';
import 'package:newsapps/service/provider/bookmarksprovider.dart';
import 'package:provider/provider.dart';
import '../../const/fontstyle.dart';
import '../../const/globalcolors.dart';
import '../../model/newsmodel.dart';
import '../../page/auth/loginpage.dart';


class ApiServices {
  static final auth = FirebaseAuth.instance;

  static Future<List<NewsModel>> getAllTopNews({required int page}) async {
    try {
      var uri = Uri.https(baseurl, "v2/everything", {
        "q": "bitcoin",
        "pageSize": "10",
        "page": page.toString(),
      });

      var response = await http.get(uri, headers: {"X-Api-Key": apiKey});
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

  static Future<List<NewsModel>> getAllNews(
      {required int pageSize, required String category}) async {
    try {
      var uri = Uri.https(baseurl, "v2/top-headlines", {
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

  static Future<List<NewsModel>> searchNewsItem({required String q}) async {
    try {
      var uri = Uri.https(baseurl, "v2/top-headlines", {
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

  static googleSignUp() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: ['email'],
      );
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final User? user = (await auth.signInWithCredential(credential)).user;
      sharedPreferences!.setString("uid", user!.uid);

      return user;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  static Future<void> logOutDialog(
      {required BuildContext context, bool isDelete = false, String? id}) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: isDelete == true
              ? Row(
                  children: [
                    const Text('Delete'),
                    Icon(
                      Icons.delete,
                      color: GlobalColors.red,
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
                foregroundColor: GlobalColors.red,
                textStyle: tabLabelStyle,
              ),
              child: const Text('Yes'),
              onPressed: () {
                isDelete == true
                    ? deletebooks(id!, context)
                    : auth.signOut().then((value) {
                        Navigator.pushNamed(context, LoginPage.routeName);
                        globalMethod.toastMessage("Logout Sucessfully");
                      }).onError((error, stackTrace) {});
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                  foregroundColor: GlobalColors.red, textStyle: tabLabelStyle),
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
    newsProvider.delete(publishedAt: id);
    globalMethod.toastMessage("Delete Sucessfully");
    Navigator.pop(context);
  }
}
