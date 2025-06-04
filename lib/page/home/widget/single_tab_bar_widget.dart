import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';
import '../../../model/news_model_.dart';
import '../../../widget/error_widget.dart';
import '../../../widget/row_widget.dart';
import '../../../service/provider/news_provider.dart';
import '../../../widget/article_item_widget.dart';
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
              Navigator.pushNamed(
                context,
                '/categoryPage',
                arguments: text,
              );

              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => CateoryPage(
              //               categoryName: text,
              //             )));
            }),
        SizedBox(height: 10.h),
        Expanded(
          child: FutureBuilder<List<NewsModel>>(
            future: newsProvider.fetchAllNews(
                category: text.toLowerCase(), pageSize: 10),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingArticleWidget();
              } else if (snapshot.hasError) {
                return const ErrorNullWidget(); // Or a custom error display
              } else if (!snapshot.hasData ||
                  snapshot.data == null ||
                  snapshot.data!.isEmpty) {
                return const ErrorNullWidget(); // Also handles empty list
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
