
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapps/const/globalcolors.dart';
import 'package:newsapps/page/news/bookmarkspage.dart';
import '../const/fontstyle.dart';
import '../const/function.dart';

import '../page/news/homepage.dart';
import '../page/innerpage/cateogrylist.dart';

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
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: GlobalColors.lightred),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GlobalMethod.applogo(),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "Jasim Uddin News",
                  style: titleTextSTyle,
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
                              color: GlobalColors.black,
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
          const Divider(
            thickness: 3,
          ),
          drawableItemMethod(
              title: 'Logout',
              icon: Icons.logout,
              function: () async {
                GlobalMethod.logOutDialog(context: context);
              
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
      leading: Icon(
        icon,
        size: 25,
        color: Colors.black,
      ),
      title: Text(title,
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  color: GlobalColors.black,
                  fontSize: 14,
                  letterSpacing: 1,
                  fontWeight: FontWeight.w600))),
      onTap: () {
        function();
      },
    );
  }
}
