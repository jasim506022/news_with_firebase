

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';

import '../const/fontstyle.dart';

import '../const/function.dart';
import '../const/globalcolors.dart';
import '../page/innerpage/categroypage.dart';
import '../service/newsprovider.dart';
import 'articlewidget.dart';
import 'loadingarticlewidget.dart';

class SingleTabBarViewWidget extends StatelessWidget {
  const SingleTabBarViewWidget({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text, style: titleTextSTyle),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CategoryPage(
                              categoryname: text,
                            )));
              },
              child: Text("See All",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: GlobalColors.black,
                          fontSize: 14,
                          letterSpacing: 1,
                          fontStyle: FontStyle.normal))),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: FutureBuilder(
            future: newsProvider.fetchAllTopNews(category: text.toLowerCase(), pageSize: 10),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingArticleWidget();
              } else if (snapshot.hasError) {
               return GlobalMethod.errorMethod(error: snapshot.error.toString());
              } else if (!snapshot.hasData) {
                return Image.asset("asset/image/nonewsitemfound.png");
              }
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ChangeNotifierProvider.value(
                    value: snapshot.data![index],
                    child:  const ArticleItemWidget(),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
