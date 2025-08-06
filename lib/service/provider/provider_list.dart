import 'package:provider/provider.dart';

import 'bookmarks_provider.dart';
import 'loadingprovider.dart';
import 'news_provider.dart';
import 'onboarding_provide.dart';
import 'search_provider.dart';
import 'splash_provider.dart';
import 'theme_mode_provider.dart';
import 'web_view_progress_provider.dart';

List<ChangeNotifierProvider> appProviders = [
  ChangeNotifierProvider(create: (_) => NewsProvider()),
  ChangeNotifierProvider(create: (_) => BookmarksProvider()),
  ChangeNotifierProvider(create: (_) => ThemeModeProvider()),
  ChangeNotifierProvider(create: (_) => LoadingProvider()),
  ChangeNotifierProvider(create: (_) => SplashProvider()),
  ChangeNotifierProvider(create: (_) => OnboardingProvider()),
  ChangeNotifierProvider(create: (_) => SearchProvider()),
  ChangeNotifierProvider(create: (_) => WebViewProgressProvider()),
];
