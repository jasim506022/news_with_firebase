import 'package:flutter/material.dart';
import 'package:newsapps/res/const.dart';
import 'package:newsapps/widget/rowwidget.dart';
import 'package:provider/provider.dart';
import '../page/innerpage/categroypage.dart';
import '../service/provider/newsprovider.dart';
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
        RowWidget(
            title: text,
            function: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CategoryPage(
                            categoryname: text,
                          )));
            }),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: FutureBuilder(
            future: newsProvider.fetchAllNews(
                category: text.toLowerCase(), pageSize: 10),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingArticleWidget();
              } else if (snapshot.hasError) {
                return globalMethod.errorMethod(
                    error: snapshot.error.toString());
              } else if (!snapshot.hasData) {
                return Image.asset("asset/image/nonewsitemfound.png");
              }
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ChangeNotifierProvider.value(
                    value: snapshot.data![index],
                    child: const ArticleItemWidget(),
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
