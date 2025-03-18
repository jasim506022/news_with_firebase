import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsapps/page/newss/detailsnews.dart';
import 'package:newsapps/page/newss/detailsnewswebsite.dart';
import 'package:newsapps/res/app_routes.dart';
import 'package:newsapps/res/const.dart';
import 'package:newsapps/page/auth/log_in_page.dart';
import 'package:newsapps/page/splash/splash_page.dart';
import 'package:newsapps/page/newss/alltopnews.dart';
import 'package:newsapps/page/news/cateogrylist.dart';
import 'package:newsapps/page/news/searchpage.dart';
import 'package:newsapps/page/home/home_page.dart';
import 'package:newsapps/service/provider/auth_provider.dart';
import 'package:newsapps/service/provider/bookmarksprovider.dart';
import 'package:newsapps/service/provider/loadingprovider.dart';
import 'package:newsapps/service/provider/news_provider.dart';
import 'package:newsapps/service/provider/onboarding_provide.dart';
import 'package:newsapps/service/provider/splash_provider.dart';
import 'package:newsapps/service/provider/themeprovider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'model/news_model_.dart';
import 'page/newss/bookmarkspage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  sharedPreferences = await SharedPreferences.getInstance();
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.debug,
  );
  isViewd = sharedPreferences!.getInt("onBoard");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(450, 851),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => NewsProvider()),
          ChangeNotifierProvider(create: (context) => BookmarksProvider()),
          ChangeNotifierProvider(create: (context) => ThemeProvider()),
          ChangeNotifierProvider(create: (context) => LoadingProvider()),
          ChangeNotifierProvider(create: (context) => SplashProvider()),
          ChangeNotifierProvider(create: (context) => OnboardingProvider()),
          // ChangeNotifierProvider(
          //   create: (context) => AuthProvider(),
          // ),
          ChangeNotifierProxyProvider<LoadingProvider, AuthProvider>(
            create: (_) => AuthProvider(),
            update: (_, loadingProvider, authProvider) {
              authProvider?.setLoadingProvider(
                  loadingProvider); // Inject LoadingProvider
              return authProvider!;
            },
          ),
        ],
        child: Consumer<ThemeProvider>(
          builder: (context, value, child) {
            return MaterialApp(
              onGenerateRoute: (settings) {
                if (settings.name == AppRoutes.newsDetailsPage) {
                  final newsModel = settings.arguments as NewsModel;
                  return MaterialPageRoute(
                    builder: (context) => NewsDetailsPage(newsModel: newsModel),
                  );
                } else if (settings.name == AppRoutes.detailsNewsWebPage) {
                  final url = settings.arguments as String;
                  return MaterialPageRoute(
                    builder: (context) => DetailsNewsWebPage(url: url),
                  );
                }
              },
              debugShowCheckedModeBanner: false,
              theme: globalMethod.themeDate(value),
              home: const SplashPage(),
              routes: {
                LoginPage.routeName: (context) => const LoginPage(),
                SearchPage.routeName: (context) => const SearchPage(),
                AppRoutes.homePage: (context) => const HomePage(),
                AppRoutes.allNewsPage: (context) => const AllTopNews(),
                CategoryList.routeName: (context) => const CategoryList(),
                BookmarskPage.routeName: (context) => const BookmarskPage(),
              },
            );
          },
        ),
      ),
    );
  }
}
