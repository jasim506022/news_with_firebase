import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapps/model/bookmarksmodel.dart';
import 'package:newsapps/model/news_model_.dart';
import 'package:newsapps/res/app_function.dart';
import 'package:provider/provider.dart';
import '../res/app_text_style.dart';
import '../res/app_colors.dart';
import '../page/newss/detailsnews.dart';
import '../page/newss/detailsnewswebsite.dart';
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
    double width = MediaQuery.of(context).size.width;
    dynamic newsmodelProvider = widget.isBookmarks == true
        ? Provider.of<BookmarksModel>(context)
        : Provider.of<NewsModel>(context);
    return Card(
      color: Theme.of(context).cardColor,
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    NewsDetailsPage(newsModel: newsmodelProvider),
              ));
        },
        onLongPress: () {
          widget.isDelete == true
              ? ApiServices.logOutDialog(
                  context: context,
                  isDelete: true,
                  id: newsmodelProvider.publishedAt)
              : Container();
        },
        child: SizedBox(
          height: 130.h,
          width: width,
          child: Container(
            padding:
                const EdgeInsets.only(left: 6, right: 6, top: 10, bottom: 12),
            child: Column(
              children: [
                Row(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Hero(
                          tag: newsmodelProvider.publishedAt,
                          child: FancyShimmerImage(
                            height: 100.h,
                            width: 100.h,
                            boxFit: BoxFit.fill,
                            errorWidget: const Image(
                              image: AssetImage("asset/image/image.jpg"),
                              fit: BoxFit.fill,
                            ),
                            imageUrl: newsmodelProvider.urlToImage,
                          ),
                        )),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            newsmodelProvider.title,
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
                                  newsmodelProvider.source,
                                  maxLines: 2,
                                  style: newstextStyle,
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DetailsNewsWebPage(
                                            url: newsmodelProvider.url,
                                          ),
                                        ));
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
                                      height: 10,
                                      width: 10,
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
                                    if (newsmodelProvider.readingTimeText ==
                                        "less than a minute")
                                      FittedBox(
                                        child: Text(
                                          "1 min ago",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  color:
                                                      AppColors.lightCardColor,
                                                  fontSize: 13.sp,
                                                  fontWeight:
                                                      FontWeight.w600)), //
                                        ),
                                      )
                                    else
                                      FittedBox(
                                        child: Text(
                                          "${newsmodelProvider.readingTimeText} mins ago",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  color:
                                                      AppColors.lightCardColor,
                                                  fontSize: 13,
                                                  fontWeight:
                                                      FontWeight.w600)), //
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
