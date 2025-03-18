import 'package:flutter/material.dart';
import 'package:newsapps/widget/error_widget.dart';
import 'package:newsapps/widget/row_widget.dart';
import 'package:provider/provider.dart';
import '../../news/categroy_page.dart';
import '../../../service/provider/news_provider.dart';
import '../../../widget/articlewidget.dart';
import '../../../widget/loadingarticlewidget.dart';

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
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CateoryPage(
                            categoryName: text,
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
                return const ErrorNullWidget();
              } else if (!snapshot.hasData) {
                return const ErrorNullWidget();
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
