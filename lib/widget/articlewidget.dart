import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapps/model/bookmarksmodel.dart';
import 'package:newsapps/model/newsmodel.dart';
import 'package:provider/provider.dart';
import '../const/fontstyle.dart';
import '../const/function.dart';
import '../const/globalcolors.dart';
import '../page/news/detailsnews.dart';
import '../page/news/detailsnewswebsite.dart';
import '../service/bookmarksprovider.dart';

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

    return Material(
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    NewsDetailsPage(newsModel: newsmodelProvider),
              ));
        },
        onDoubleTap: () {
          widget.isDelete == true
              ? 
               GlobalMethod.logOutDialog(
                  context: context,
                  isDelete: true,
                  id: newsmodelProvider.publishedAt)
              : Container();
        },
        child: SizedBox(
          height: 135,
          width: width,
          child: Card(
            shadowColor: Colors.grey,
            elevation: 3,
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
                              height: 100,
                              width: 100,
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
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              newsmodelProvider.title,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              style: titleTextstyleblack,
                            ),
                            const SizedBox(
                              height: 08,
                            ),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    FittedBox(
                                      child: Text(
                                        newsmodelProvider.source,
                                        maxLines: 1,
                                        style: newstextStyle,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    InkWell(
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
                                  ],
                                ),
                                const Spacer(),
                                Row(
                                  children: [
                                    Container(
                                      height: 10,
                                      width: 10,
                                      decoration: BoxDecoration(
                                          color: GlobalColors.white,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              width: 3,
                                              color: GlobalColors.deepred)),
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
                                                  color: GlobalColors.gray,
                                                  fontSize: 13,
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
                                                  color: GlobalColors.gray,
                                                  fontSize: 13,
                                                  fontWeight:
                                                      FontWeight.w600)), //
                                        ),
                                      ),
                                  ],
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
      ),
    );
  }
}
