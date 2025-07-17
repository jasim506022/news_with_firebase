import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';
import '../model/bookmarks_model.dart';
import '../model/news_model_.dart';
import '../res/app_function.dart';
import '../res/app_routes.dart';
import '../res/app_string.dart';
import '../res/app_text_style.dart';
import '../res/app_colors.dart';
import '../service/other/api_service.dart';
import 'safe_network_image.dart';

/// Displays a news article or bookmarked item card.
/// Tapping opens details; long press triggers deletion if enabled.
///
/// Uses Provider to access either [NewsModel] or [BookmarksModel] depending on [isBookmarks].
class ArticleItemWidget extends StatefulWidget {
  const ArticleItemWidget({
    super.key,
    this.isBookmarks = false,
    this.isDelete = false,
  });

  /// If true, the widget expects a [BookmarksModel] from Provider.
  final bool isBookmarks;

  /// If true, long-press triggers a delete dialog.
  final bool isDelete;

  @override
  State<ArticleItemWidget> createState() => _ArticleItemWidgetState();
}

class _ArticleItemWidgetState extends State<ArticleItemWidget> {
  @override
  Widget build(BuildContext context) {
    // Select model type based on isBookmarks flag
    dynamic model = widget.isBookmarks == true
        ? Provider.of<BookmarksModel>(context)
        : Provider.of<NewsModel>(context);
    return Card(
      color: Theme.of(context).cardColor,
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, AppRoutes.newsDetailsPage,
            arguments: model),
        // Show delete dialog on long press if enabled
        onLongPress: () {
          widget.isDelete == true
              ? ApiServices.logOutDialog(
                  context: context, isDelete: true, id: model.publishedAt)
              : null;
        },
        child: Container(
          height: 130.h,
          width: 1.sw,
          padding:
              EdgeInsets.only(left: 6.w, right: 6.w, top: 10.h, bottom: 12.h),
          child: Column(
            children: [
              Row(
                children: [
                  // Article image with rounded corners and hero animation
                  ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: _buildArticleImage(model)),
                  AppFunction.horizontalSpace(15),
                  // Article text content: title, source, external link, and reading time
                  Expanded(
                    child: _buildArticleDetails(model, context),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  /// Builds article title, source, external link, and reading time info
  Column _buildArticleDetails(model, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          model.title,
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
          style: AppTextStyle.mediumBoldTextStyle(context),
        ),
        AppFunction.verticalSpace(8),
        Row(
          children: [
            Expanded(
              flex: 5,
              child: Text(
                model.source,
                maxLines: 2,
                style: AppTextStyle.newstextStyle,
              ),
            ),
            Expanded(
              flex: 2,
              child: InkWell(
                onTap: () => Navigator.pushNamed(
                  context,
                  AppRoutes.detailsNewsWebPage,
                  arguments: model.url,
                ),
                child: const Icon(
                  Icons.link,
                  color: Colors.red,
                  size: 25,
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Row(
                children: [
                  Container(
                    height: 10.h,
                    width: 10.h,
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        shape: BoxShape.circle,
                        border: Border.all(width: 3, color: AppColors.deepred)),
                  ),
                  AppFunction.horizontalSpace(5),
                  FittedBox(
                    child: Text(
                      model.readingTimeText == AppString.lessThanaMinute
                          ? AppString.oneMinuteAgo
                          : "${model.readingTimeText}  ${AppString.minutesAgo}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.newstextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }

  /// Displays a Hero animated image from the article thumbnail
  Hero _buildArticleImage(model) {
    return Hero(
        tag: model.publishedAt,
        child: SafeNetworkImage(
          height: 100,
          width: 100,
          imageUrl: model.urlToImage,
          boxFit: BoxFit.fill,
        ));
  }
}
