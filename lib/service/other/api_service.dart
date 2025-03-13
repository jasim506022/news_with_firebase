import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:newsapps/res/app_function.dart';
import 'package:newsapps/res/app_string.dart';
import 'package:newsapps/res/const.dart';
import 'package:newsapps/service/provider/bookmarksprovider.dart';
import 'package:provider/provider.dart';
import '../../res/app_text_style.dart';
import '../../res/app_colors.dart';
import '../../model/news_model_.dart';
import '../../page/auth/log_in_page.dart';

class ApiServices {
  static final auth = FirebaseAuth.instance;

// Okay
  static Future<List<NewsModel>> fetchAllTopNews({required int page}) async {
    try {
      var uri = Uri.https(baseurl, "v2/everything", {
        "q": "bitcoin",
        "pageSize": "10",
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
                textStyle: tabLabelStyle,
              ),
              child: const Text('Yes'),
              onPressed: () {
                isDelete == true
                    ? deletebooks(id!, context)
                    : auth.signOut().then((value) {
                        Navigator.pushNamed(context, LoginPage.routeName);
                        AppFunction.toastMessage("Logout Sucessfully");
                      }).onError((error, stackTrace) {});
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                  foregroundColor: AppColors.red, textStyle: tabLabelStyle),
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
    AppFunction.toastMessage("Delete Sucessfully");
    Navigator.pop(context);
  }
}

class AlertDialogWidget extends StatelessWidget {
  const AlertDialogWidget(
      {super.key,
      required this.title,
      required this.icon,
      required this.content,
      this.onCancelPressed,
      required this.onConfirmPressed});

  final String title;
  final IconData icon;
  final String content;
  final VoidCallback? onCancelPressed;
  final VoidCallback onConfirmPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(children: [
        Text(title),
        SizedBox(width: 10.w),
        Container(
            padding: EdgeInsets.all(5.r),
            decoration:
                BoxDecoration(color: AppColors.red, shape: BoxShape.circle),
            child: Icon(icon, color: AppColors.white))
      ]),
      content: Text(content),
      actions: <Widget>[
        OutlinedTextButtonWidget(
            color: Colors.green,
            title: AppString.btnYes,
            onPressed: onConfirmPressed),
        OutlinedTextButtonWidget(
            color: AppColors.red,
            title: AppString.btnNo,
            onPressed: onCancelPressed ?? () => Navigator.of(context).pop())
      ],
    );
  }
}

class OutlinedTextButtonWidget extends StatelessWidget {
  const OutlinedTextButtonWidget({
    super.key,
    required this.onPressed,
    required this.color,
    required this.title,
  });

  final VoidCallback onPressed;
  final Color color;
  final String title;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
            side: BorderSide(
              color: color,
              width: 2.h,
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r))),
        onPressed: onPressed,
        child: Text(title, style: AppTextStyle.button.copyWith(color: color)));
  }
}
