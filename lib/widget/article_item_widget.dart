import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';
import '../model/bookmarks_model.dart';
import '../model/news_model_.dart';
import '../res/app_function.dart';
import '../res/app_text_style.dart';
import '../res/app_colors.dart';
import '../service/other/api_service.dart';

class ArticleItemWidget extends StatefulWidget {
  const ArticleItemWidget({
    super.key,
    this.isBookmarks = false,
    this.isDelete = false,
  });

  final bool? isBookmarks;
  final bool? isDelete;

  @override
  State<ArticleItemWidget> createState() => _ArticleItemWidgetState();
}

class _ArticleItemWidgetState extends State<ArticleItemWidget> {
  @override
  Widget build(BuildContext context) {
    dynamic mdoel = widget.isBookmarks == true
        ? Provider.of<BookmarksModel>(context)
        : Provider.of<NewsModel>(context);
    return Card(
      color: Theme.of(context).cardColor,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/newsDetails', arguments: mdoel);
        },
        onLongPress: () {
          widget.isDelete == true
              ? ApiServices.logOutDialog(
                  context: context, isDelete: true, id: mdoel.publishedAt)
              : Container();
        },
        child: SizedBox(
          height: 130.h,
          width: 1.sw,
          child: Container(
            padding:
                EdgeInsets.only(left: 6.w, right: 6.w, top: 10.h, bottom: 12.h),
            child: Column(
              children: [
                Row(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(12.r),
                        child: Hero(
                          tag: mdoel.publishedAt,
                          child: FancyShimmerImage(
                            height: 100.h,
                            width: 100.h,
                            boxFit: BoxFit.fill,
                            errorWidget: const Image(
                              image: AssetImage("asset/image/image.jpg"),
                              fit: BoxFit.fill,
                            ),
                            imageUrl: mdoel.urlToImage,
                          ),
                        )),
                    SizedBox(width: 15.w),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            mdoel.title,
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
                                  mdoel.source,
                                  maxLines: 2,
                                  style: AppTextStyle.newstextStyle,
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      '/etailsNewsWebPage',
                                      arguments: mdoel.url,
                                    );
                                  },
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
                                          border: Border.all(
                                              width: 3,
                                              color: AppColors.deepred)),
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    if (mdoel.readingTimeText ==
                                        "less than a minute")
                                      FittedBox(
                                        child: Text("1 min ago",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: AppTextStyle.newstextStyle),
                                      )
                                    else
                                      FittedBox(
                                        child: Text(
                                          "${mdoel.readingTimeText} mins ago",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: AppTextStyle.newstextStyle, //
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
