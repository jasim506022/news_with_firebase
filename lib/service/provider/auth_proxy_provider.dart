import 'package:provider/provider.dart';

import 'auth_manager_provider.dart';
import 'loadingprovider.dart';

ChangeNotifierProxyProvider<LoadingProvider, AuthManageProvider>
    authProxyProvider = ChangeNotifierProxyProvider(
  create: (_) => AuthManageProvider(),
  update: (_, loadingProvider, authProvider) {
    authProvider?.setLoadingProvider(loadingProvider);
    return authProvider!;
  },
);
