import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapps/res/const.dart';
import 'package:newsapps/page/news/bookmarkspage.dart';
import 'package:provider/provider.dart';
import '../res/app_text_style.dart';

import '../page/news/homepage.dart';
import '../page/innerpage/cateogrylist.dart';
import '../service/other/apiservice.dart';
import '../service/provider/themeprovider.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({
    super.key,
  });

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Drawer(
      backgroundColor: Theme.of(context).cardColor,
      child: ListView(
        children: [
          DrawerHeader(
            decoration:
                BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                globalMethod.applogo(),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "Jasim Uddin News",
                  style: AppTextStyle.titleTextSTyle(context),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "jasimrony50@gmail.com",
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Theme.of(context).iconTheme.color,
                              fontSize: 12,
                              letterSpacing: 1,
                              fontWeight: FontWeight.w800)),
                    ),
                    const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                    )
                  ],
                )
              ],
            ),
          ),
          drawableItemMethod(
              title: 'Home',
              icon: Icons.home,
              function: () {
                Navigator.pushNamed(context, HomePage.routeName);
              }),
          drawableItemMethod(
              title: 'News Category',
              icon: Icons.category,
              function: () {
                Navigator.pushNamed(context, CategoryList.routeName);
              }),
          drawableItemMethod(
              title: 'Bookmarks',
              icon: Icons.bookmark,
              function: () {
                Navigator.pushNamed(context, BookmarskPage.routeName);
              }),
          SwitchListTile(
            title: Text(themeProvider.getDarkTheme ? "Dark" : "Light",
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: Theme.of(context).iconTheme.color,
                        fontSize: 14,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w600))),
            secondary: Icon(
                themeProvider.getDarkTheme ? Icons.dark_mode : Icons.light_mode,
                size: 25,
                color: Theme.of(context).iconTheme.color),
            value: themeProvider.getDarkTheme,
            onChanged: (value) {
              setState(() {
                themeProvider.setDarkTheme = value;
              });
            },
          ),
          const Divider(
            thickness: 3,
          ),
          drawableItemMethod(
              title: 'Logout',
              icon: Icons.logout,
              function: () async {
                ApiServices.logOutDialog(context: context);
              }),
        ],
      ),
    );
  }

  ListTile drawableItemMethod(
      {required String title,
      required IconData icon,
      required Function function}) {
    return ListTile(
      leading: Icon(icon, size: 25, color: Theme.of(context).iconTheme.color),
      title: Text(title,
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  color: Theme.of(context).iconTheme.color,
                  fontSize: 14,
                  letterSpacing: 1,
                  fontWeight: FontWeight.w600))),
      onTap: () {
        function();
      },
    );
  }
}
