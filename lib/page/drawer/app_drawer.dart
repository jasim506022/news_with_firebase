import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../res/app_routes.dart';
import '../../res/app_string.dart';

import '../../service/provider/auth_manager_provider.dart';
import '../../widget/confirmation_dialog.dart';
import 'widget/drawer_header_widget.dart';
import 'widget/navigation_drawer_item.dart';
import 'widget/theme_toggle_switch.dart';

/// Drawer widget that displays app navigation, theme toggle, and logout.
class AppDrawer extends StatelessWidget {
  AppDrawer({super.key});

  /// List of drawer navigation items with title, icon, and route.
  final List<Map<String, dynamic>> navigationItems = [
    {
      'title': AppString.homeAppBarTitle,
      'icon': Icons.home,
      'route': AppRoutes.homePage,
    },
    {
      'title': AppString.newCategoryTitle,
      'icon': Icons.category,
      'route': AppRoutes.categoryListPage,
    },
    {
      'title': AppString.bookmarkTitle,
      'icon': Icons.bookmark,
      'route': AppRoutes.bookmarksPage,
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Obtain AuthManageProvider without listening to avoid unnecessary rebuilds
    final authProvider =
        Provider.of<AuthManageProvider>(context, listen: false);

    return Drawer(
      backgroundColor: Theme.of(context).cardColor,
      child: ListView(
        children: [
          // Drawer header showing user info and app logo
          const DrawerHeaderWidget(),

          // Generate drawer navigation items dynamically from the list
          ...navigationItems.map((item) => NavigationDrawerItem(
              title: item['title'] as String,
              icon: item['icon'] as IconData,
              onTap: () =>
                  Navigator.pushNamed(context, item['route'] as String))),

          // Theme mode toggle switch (dark/light
          const ThemeToggleSwitch(),

          const Divider(thickness: 3),

          // Logout button with confirmation dialog
          NavigationDrawerItem(
              title: AppString.logOut,
              icon: Icons.logout,
              onTap: () => showDialog(
                    context: context,
                    builder: (context) => ConfirmationDialog(
                        dialogTitle: AppString.logOut,
                        dialogIcon: Icons.logout,
                        message: AppString.confirmLogoutMessage,
                        onConfirm: () async {
                          await authProvider.logOut(context);
                          if (!context.mounted) return;
                          Navigator.pop(context);
                        }),
                  )),
        ],
      ),
    );
  }
}

/*
1. Use Navigator.pushReplacementNamed if you want to avoid building multiple instances of the same page on stack.
2. Add accessibility labels or semantic widgets if needed.
3. Yes, making a separate widget class for reusable UI components is considered good practice in Flutter for several reasons:
4. We don’t need to use a StatefulWidget for the ThemeSwitchTile because state is already managed by the ThemeProvider, which is a ChangeNotifier provided by the Provider package.
5. ... (Spread Operator) It is used to insert multiple widgets into a list of widgets.
6. Why use await and asyn
7. Obtain AuthManageProvider without listening to avoid unnecessary rebuilds ( understand this code)
8. if (!context.mounted) return;
9.Using listen: false for authProvider avoids unnecessary widget rebuilds when auth state changes — improving performance.

*/

/*
TextStyle(
                              color: Theme.of(context).iconTheme.color,
                              fontSize: 12,
                              letterSpacing: 1,
                              fontWeight: FontWeight.w800)
                              1. When use Function and when use void call back
*/

