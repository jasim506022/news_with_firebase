import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'auth_manager_provider.dart';
import 'bookmarks_provider.dart';
import 'loadingprovider.dart';
import 'news_provider.dart';
import 'onboarding_provide.dart';
import 'search_provider.dart';
import 'splash_provider.dart';
import 'theme_mode_provider.dart';
import 'web_view_progress_provider.dart';

/// List of app-wide providers for ChangeNotifier-based state management.
/// This list is used in MultiProvider to inject dependencies into the widget tree.
final List<SingleChildWidget> appProviders = [
  ChangeNotifierProvider(create: (_) => NewsProvider()),
  ChangeNotifierProvider(create: (_) => BookmarksProvider()),
  ChangeNotifierProvider(create: (_) => ThemeModeProvider()),
  ChangeNotifierProvider(create: (_) => LoadingProvider()),
  ChangeNotifierProvider(create: (_) => SplashProvider()),
  ChangeNotifierProvider(create: (_) => OnboardingProvider()),
  ChangeNotifierProvider(create: (_) => SearchProvider()),
  ChangeNotifierProvider(create: (_) => WebViewProgressProvider()),
];

/// Proxy provider that allows `AuthManager` to listen to changes in `LoadingProvider`.
///
/// `AuthManager` depends on the `LoadingProvider` to update loading state during authentication flows.
/// Here, we inject `LoadingProvider` instance into `AuthManager`.

ChangeNotifierProxyProvider<LoadingProvider, AuthManageProvider>
    authProxyProvider = ChangeNotifierProxyProvider(
  create: (_) => AuthManageProvider(),
  update: (_, loadingProvider, authProvider) {
    authProvider?.setLoadingProvider(loadingProvider);
    return authProvider!;
  },
);
