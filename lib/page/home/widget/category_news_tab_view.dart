import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../../../model/news_model_.dart';
import '../../../res/app_function.dart';
import '../../../res/app_routes.dart';
import '../../../widget/no_data_placeholder.dart';
import '../../../widget/section_header_widget.dart';
import '../../../service/provider/news_provider.dart';
import '../../../widget/article_item_widget.dart';
import '../../../loading/loading_articles_list_widget.dart';

/// Displays a category news tab with header and a list of articles.
///
/// Fetches news for a specific [categoryLabel] and shows a "View All" link in the header.
class CategoryNewsTabView extends StatelessWidget {
  const CategoryNewsTabView({
    super.key,
    required this.categoryLabel,
  });

  /// The title of the category (e.g., "Technology", "Sports")
  final String categoryLabel;
  @override
  Widget build(BuildContext context) {
    // Access the NewsProvider without listening to avoid unnecessary rebuilds
    final newsProvider = Provider.of<NewsProvider>(context, listen: false);
    return Column(
      children: [
        /// Category section header with a "View All" navigation
        SectionHeaderRow(
            title: categoryLabel,
            onTap: () => Navigator.pushNamed(
                  context,
                  AppRoutes.categoryPage,
                  arguments: categoryLabel,
                )),
        AppFunction.verticalSpace(10),

        /// Load and display news articles based on the category
        Expanded(
          child: FutureBuilder<List<NewsModel>>(
            future: newsProvider.fetchNewsByCategory(
                category: categoryLabel.toLowerCase(), pageSize: 10),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingArticleWidget();
              }
              if (snapshot.hasError) {
                return const NoDataPlaceholder();
              }

              final articles = snapshot.data!;
              if (articles.isEmpty) {
                return const NoDataPlaceholder();
              }

              return ListView.builder(
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  return ChangeNotifierProvider.value(
                    value: articles[index],
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
