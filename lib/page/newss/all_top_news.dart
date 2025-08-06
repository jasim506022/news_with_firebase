import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';

import '../../res/app_colors.dart';
import '../../res/app_string.dart';
import '../../res/app_text_style.dart';

import '../../service/provider/news_provider.dart';
import '../../widget/article_item_widget.dart';
import '../../loading/loading_articles_list_widget.dart';
import '../../widget/no_results_widget.dart';

/// A page that displays top news articles with pagination functionality.

class AllTopNews extends StatefulWidget {
  const AllTopNews({super.key});

  @override
  State<AllTopNews> createState() => _AllTopNewsState();
}

class _AllTopNewsState extends State<AllTopNews> {
  @override
  void initState() {
    // Initialize the current index to 0 when the screen loads.
    Future.microtask(() =>
        Provider.of<NewsProvider>(context, listen: false).setCurrentIndex(0));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppString.topNews),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            /// Pagination bar with previous, page numbers, and next buttons
            _buildPaginationBar(newsProvider),

            /// News article list based on the selected page
            Expanded(
              child: FutureBuilder(
                future: newsProvider.fetchTopNews(
                    page: newsProvider.currentindex + 1),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const LoadingArticleWidget();
                  } else if (snapshot.hasError) {
                    return NoResultsWidget(title: snapshot.error.toString());
                  } else if (!snapshot.hasData) {
                    return const NoResultsWidget(title: AppString.noData);
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
        ),
      ),
    );
  }

  /// Builds the pagination bar with previous, numbered pages, and next buttons.
  ///
  /// [newsProvider] is used to track the current index and update it.
  SizedBox _buildPaginationBar(NewsProvider newsProvider) {
    const totalPages = 10;
    final currentIndex = newsProvider.currentindex;

    return SizedBox(
      height: kBottomNavigationBarHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          /// Previous page button
          _paginationButton(
            label: AppString.pre,
            onPressed:
                currentIndex > 0 ? newsProvider.removeCurrentIndex : null,
          ),

          /// Numbered pagination buttons (1–10)
          Expanded(
            child: ListView.builder(
              itemCount: totalPages,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final isSelected = currentIndex == index;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () => newsProvider.setCurrentIndex(index),
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.red : AppColors.white,
                        borderRadius: BorderRadius.circular(6.r),
                        border: Border.all(color: AppColors.red),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 8.h,
                        horizontal: 12.w,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "${index + 1}",
                        style: AppTextStyle.buttonTextStyle().copyWith(
                          color: isSelected ? AppColors.white : AppColors.black,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          /// Next page button
          _paginationButton(
              label: AppString.btnNext,
              onPressed: currentIndex < totalPages - 1
                  ? newsProvider.addCurrentIndex
                  : null),
        ],
      ),
    );
  }

  /// Creates a styled pagination button.
  ///
  /// - [label]: Text shown on the button (e.g., "Pre", "Next")
  /// - [onPressed]: Function to call when button is pressed. If null, button is disabled.
  Widget _paginationButton({
    required String label,
    VoidCallback? onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.disabled)) {
            return Colors.grey;
          }
          return AppColors.deepred;
        }),
        foregroundColor:
            WidgetStateProperty.resolveWith<Color>((states) => AppColors.white),
      ),
      child: Text(
        label,
        style: AppTextStyle.buttonTextStyle(),
      ),
    );
  }

  /*
  Widget _paginationButton(
          {required VoidCallback? onPressed, required String label}) =>
      ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor:
                onPressed != null ? AppColors.deepred : Colors.black,
          ),
          child: Text(label, style: AppTextStyle.button));

*/
}

/*
1. kBottomNavigationBarHeight
2. Difference 
onPressed: () {
          function();
        },
        onPressed: onPressed,
        1. Function or VoidCallBack
*/

/*

1. 
            /*
             () {
              if (newsProvider.currentindex == 0) {
                return;
              }
              newsProvider.removeCurrentIndex();
            },
*/
2.
/*
            onPressed: () {
              if (newsProvider.currentindex == 10) {
                return;
              }
              newsProvider.addCurrentIndex();
            },
            */

  // Future.delayed(
    //   Duration.zero,
    //   () {
    //     Provider.of<NewsProvider>(context, listen: false).setCurrentIndex(0);
    //   },
    // );

    // Ensure provider currentIndex is set when this page is first loaded


*/

