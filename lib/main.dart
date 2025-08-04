import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsapps/page/auth/login_phone_number_page.dart';
import 'package:newsapps/page/auth/sign_up_page.dart';
import 'package:newsapps/page/auth/verify_code_page.dart';
import 'package:newsapps/service/provider/search_provider.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'page/auth/log_in_page.dart';
import 'page/home/home_page.dart';
import 'page/news/category_list.dart';
import 'page/news/categroy_page.dart';
import 'page/search/search_page.dart';
import 'page/newss/all_top_news.dart';
import 'page/newss/bookmarks_page.dart';
import 'page/newss/news_detail_page.dart';
import 'page/web/web_view_news_page.dart';
import 'page/splash/splash_page.dart';
import 'res/app_routes.dart';
import 'res/app_constant.dart';
import 'res/app_string.dart';
import 'service/provider/auth_manager_provider.dart';
import 'service/provider/bookmarks_provider.dart';
import 'service/provider/loadingprovider.dart';
import 'service/provider/news_provider.dart';
import 'service/provider/onboarding_provide.dart';
import 'service/provider/splash_provider.dart';
import 'service/provider/themeprovider.dart';
import 'service/provider/web_view_progress_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  AppConstant.sharedPreferences = await SharedPreferences.getInstance();
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.playIntegrity,
    // androidProvider: AndroidProvider.safetyNet,
  );
  AppConstant.isViewd =
      AppConstant.sharedPreferences!.getInt(AppString.onboardSharePrefer) ?? 0;
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
          ChangeNotifierProvider(create: (context) => SearchProvider()),
          ChangeNotifierProvider(
              create: (context) => WebViewProgressProvider()),
          ChangeNotifierProxyProvider<LoadingProvider, AuthManageProvider>(
            create: (_) => AuthManageProvider(),
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
              debugShowCheckedModeBanner: false,
              theme: globalMethod.themeDate(value),
              home: const SplashPage(),
              routes: {
                AppRoutes.logInPage: (context) => const LoginPage(),
                AppRoutes.signUpPage: (context) => const SignUpPage(),
                AppRoutes.loginWithPhoneNumberPage: (context) =>
                    const LoginPhoneNumberPage(),
                AppRoutes.verifiyCodePage: (context) => const VerifyCodePage(),
                AppRoutes.searchPage: (context) => const SearchPage(),
                AppRoutes.homePage: (context) => const HomePage(),
                AppRoutes.allNewsPage: (context) => const AllTopNews(),
                AppRoutes.categoryListPage: (context) => const CategoryList(),
                // AppRoutes.categoryName: (context) => const CateoryPage(),
                AppRoutes.bookmarksPage: (context) => const BookmarksPage(),
                AppRoutes.newsDetailsPage: (context) => const NewsDetailsPage(),
                AppRoutes.detailsNewsWebPage: (context) =>
                    const WebViewNewsPage(),
                AppRoutes.categoryName: (context) => const CateoryPage(),
              },
            );
          },
        ),
      ),
    );
  }
}
