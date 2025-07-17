import 'package:flutter/material.dart';

import 'article_shimmer_placeholder.dart';

class LoadingArticleWidget extends StatelessWidget {
  const LoadingArticleWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (context, index) {
        return const ArticleShimmerPlaceholder();
      },
    );
  }
}
