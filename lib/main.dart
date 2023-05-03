import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newsapps/page/loginout/splashpage.dart';
import 'package:newsapps/page/news/alltopnews.dart';
import 'package:newsapps/page/innerpage/cateogrylist.dart';
import 'package:newsapps/page/innerpage/searchpage.dart';
import 'package:newsapps/page/loginout/loginpage.dart';
import 'package:newsapps/page/news/homepage.dart';
import 'package:newsapps/service/bookmarksprovider.dart';
import 'package:newsapps/service/newsprovider.dart';
import 'package:newsapps/service/othersprovider.dart';
import 'package:provider/provider.dart';
import 'const/globalcolors.dart';
import 'page/news/bookmarkspage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
          create: (context) => IsBookmarkProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => BookmarksProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            appBarTheme: AppBarTheme(
                systemOverlayStyle: SystemUiOverlayStyle(
                    systemNavigationBarColor: GlobalColors.white,
                    systemNavigationBarIconBrightness: Brightness.dark,
                    statusBarIconBrightness: Brightness.dark,
                    statusBarColor: Colors.white)),
            scaffoldBackgroundColor: GlobalColors.white,
            primaryColor: GlobalColors.red),
        home: const SplashPage(),
        routes: {
          //NewsDetailsPage.routeName: (context) => const NewsDetailsPage(),
          LoginPage.routeName: (context) => const LoginPage(),
          SearchPage.routeName: (context) => const SearchPage(),
          HomePage.routeName: (context) => const HomePage(),
          AllTopNews.routeName: (context) => const AllTopNews(),
          CategoryList.routeName: (context) => const CategoryList(),
          BookmarskPage.routeName: (context) => const BookmarskPage(),

          //   CategoryPage.routeName :(context) => const CategoryPage(),
        },
      ),
    );
  }
}
