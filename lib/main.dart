import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as developer;

// Resources
import 'page/splash/splash_page.dart';
import 'res/app_routes.dart';
import 'res/app_theme.dart';
import 'res/app_constant.dart';
import 'res/app_string.dart';
import 'service/provider/auth_proxy_provider.dart';
import 'service/provider/provider_list.dart';
import 'service/provider/theme_mode_provider.dart';

/// The main entry point of the application
///
/// Initializes Firebase, App Check, and SharedPreferences,
/// then launches the Flutter application.

void main() async {
  // Ensure Flutter bindings are initialized before doing async work
  WidgetsFlutterBinding.ensureInitialized();

  //Initialize Firebase
  await _initializeFirebase();

  // Enable Firebase App Check (e.g., Play Integrity for Android)
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.playIntegrity,
  );

  // Check if onboarding was already viewed (used to decide whether to show onboarding screen)
  await _loadSharedPreferences();

  // Launch the app
  runApp(const MyApp());
}

/// Firebase Initialization with error handling
Future<void> _initializeFirebase() async {
  try {
    await Firebase.initializeApp();
  } catch (e, stackTrace) {
    developer.log("Firebase initialization failed: $e", stackTrace: stackTrace);
  }
}

/// Firebase Initialization with error handling
Future<void> _loadSharedPreferences() async {
  try {
    AppConstants.sharedPreferences = await SharedPreferences.getInstance();
    // Check onboarding status
    AppConstants.isOnboardingViewed = AppConstants.sharedPreferences?.getBool(
          AppString.onboardSharePrefer,
        ) ??
        false;
  } catch (e) {
    developer.log("Error loading SharedPreferences: $e");
  }
}

/// The root widget of the app
///
/// Sets up screen size adaptation, providers, theming, and routing.
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(450, 851),
      child: MultiProvider(
        providers: [...appProviders, authProxyProvider],
        child: Consumer<ThemeModeProvider>(
          builder: (context, themeModelProvider, _) {
            return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: AppTheme(
                  context: context,
                  isDark: themeModelProvider.isDarkTheme,
                ).build(),
                home: const SplashPage(),
                routes: AppRoutes.routes);
          },
        ),
      ),
    );
  }
}








/*

     {
                AppRoutes.signInPage: (_) => const LoginPage(),
                AppRoutes.signUpPage: (_) => const SignUpPage(),
                AppRoutes.loginWithPhonePage: (_) =>
                    const LoginPhoneNumberPage(),
                AppRoutes.verifyCodePage: (_) => const VerifyCodePage(),
                AppRoutes.searchPage: (_) => const SearchPage(),
                AppRoutes.homePage: (_) => const HomePage(),
                AppRoutes.allNewsPage: (_) => const AllTopNews(),
                AppRoutes.categoryListPage: (_) => const CategoryList(),
                AppRoutes.bookmarksPage: (_) => const BookmarksPage(),
                AppRoutes.newsDetailsPage: (_) => const NewsDetailsPage(),
                AppRoutes.detailsNewsWebPage: (_) => const WebViewNewsPage(),
                AppRoutes.categoryPage: (_) => const CategoryPage(),
              },



// Providers
import 'service/provider/auth_manager_provider.dart';
import 'service/provider/auth_proxy_provider.dart';
import 'service/provider/bookmarks_provider.dart';
import 'service/provider/loadingprovider.dart';
import 'service/provider/news_provider.dart';
import 'service/provider/onboarding_provide.dart';
import 'service/provider/provider_list.dart';
import 'service/provider/search_provider.dart';
import 'service/provider/splash_provider.dart';
import 'service/provider/themeprovider.dart';
import 'service/provider/web_view_progress_provider.dart';


 /*
        providers: [
          // ChangeNotifierProvider(create: (context) => NewsProvider()),
          ChangeNotifierProvider(create: (_) => NewsProvider()),
          ChangeNotifierProvider(create: (_) => BookmarksProvider()),
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
          ChangeNotifierProvider(create: (_) => LoadingProvider()),
          ChangeNotifierProvider(create: (_) => SplashProvider()),
          ChangeNotifierProvider(create: (_) => OnboardingProvider()),
          ChangeNotifierProvider(create: (_) => SearchProvider()),
          ChangeNotifierProvider(create: (_) => WebViewProgressProvider()),
          // Auth provider needs LoadingProvider injected dynamically
          ChangeNotifierProxyProvider<LoadingProvider, AuthManageProvider>(
            create: (_) => AuthManageProvider(),
            update: (_, loadingProvider, authProvider) {
              authProvider?.setLoadingProvider(loadingProvider);
              return authProvider!;
            },
          ),
        ],
*/



*/