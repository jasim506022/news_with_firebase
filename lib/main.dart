import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:newsapps/const/const.dart';
import 'package:newsapps/page/auth/loginpage.dart';
import 'package:newsapps/page/auth/splashpage.dart';
import 'package:newsapps/page/news/alltopnews.dart';
import 'package:newsapps/page/innerpage/cateogrylist.dart';
import 'package:newsapps/page/innerpage/searchpage.dart';
import 'package:newsapps/page/news/homepage.dart';
import 'package:newsapps/service/provider/bookmarksprovider.dart';
import 'package:newsapps/service/provider/loadingprovider.dart';
import 'package:newsapps/service/provider/newsprovider.dart';
import 'package:newsapps/service/provider/themeprovider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'page/news/bookmarkspage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  sharedPreferences = await SharedPreferences.getInstance();
  isViewd = sharedPreferences!.getInt("onBoard");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => NewsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => BookmarksProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => LoadingProvider(),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, value, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: globalMethod.themeDate(value),
            home: const SplashPage(),
            routes: {
              LoginPage.routeName: (context) => const LoginPage(),
              SearchPage.routeName: (context) => const SearchPage(),
              HomePage.routeName: (context) => const HomePage(),
              AllTopNews.routeName: (context) => const AllTopNews(),
              CategoryList.routeName: (context) => const CategoryList(),
              BookmarskPage.routeName: (context) => const BookmarskPage(),
            },
          );
        },
      ),
    );
  }
}
