import 'package:flutter/material.dart';

// Pages
import '../page/auth/log_in_page.dart';
import '../page/auth/login_phone_number_page.dart';
import '../page/auth/sign_up_page.dart';
import '../page/auth/verify_code_page.dart';
import '../page/home/home_page.dart';
import '../page/news/category_list.dart';
import '../page/news/categroy_page.dart';
import '../page/newss/all_top_news.dart';
import '../page/newss/bookmarks_page.dart';
import '../page/newss/news_detail_page.dart';
import '../page/search/search_page.dart';
import '../page/web/web_view_news_page.dart';

class AppRoutes {
  // Auth-related routes
  static const String signInPage = "/signIn";
  static const String signUpPage = "/signUp";
  static const String loginWithPhonePage = "/loginWithPhone";
  static const String verifyCodePage = "/verifyCode";

  // Core pages
  static const String homePage = "/home";
  static const String searchPage = "/search";

  // News-related pages
  static const String allNewsPage = "/allNews";
  static const String newsDetailsPage = "/newsDetails";
  static const String detailsNewsWebPage = "/detailsNewsWeb";

  // Category-related pages
  static const String categoryListPage = '/categoryList';
  static const String categoryPage = "/category";

  // Bookmarks
  static const String bookmarksPage = "/bookmarks";

  static Map<String, WidgetBuilder> routes = {
    signInPage: (_) => const LoginPage(),
    signUpPage: (_) => const SignUpPage(),
    loginWithPhonePage: (_) => const LoginPhoneNumberPage(),
    verifyCodePage: (_) => const VerifyCodePage(),
    searchPage: (_) => const SearchPage(),
    homePage: (_) => const HomePage(),
    allNewsPage: (_) => const AllTopNews(),
    categoryListPage: (_) => const CategoryList(),
    bookmarksPage: (_) => const BookmarksPage(),
    newsDetailsPage: (_) => const NewsDetailsPage(),
    detailsNewsWebPage: (_) => const WebViewNewsPage(),
    categoryPage: (_) => const CategoryPage(),
  };
}

// When use ' and when " "
