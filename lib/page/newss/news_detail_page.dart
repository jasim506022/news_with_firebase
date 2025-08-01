import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';
import '../../model/news_model_.dart';
import '../../res/app_colors.dart';
import '../../res/app_function.dart';
import '../../res/app_string.dart';
import '../../res/app_text_style.dart';
import '../../service/provider/bookmarks_provider.dart';
import '../../widget/safe_network_image.dart';

/// Displays detailed view of a news article, including image, content,
/// author/source info, and options to bookmark/share.
class NewsDetailsPage extends StatefulWidget {
  const NewsDetailsPage({super.key});

  @override
  State<NewsDetailsPage> createState() => _NewsDetailsPageState();
}

class _NewsDetailsPageState extends State<NewsDetailsPage> {
  late final NewsModel newsModel;
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    // Load the news article from route arguments only once
    if (_isInit) {
      newsModel = ModalRoute.of(context)!.settings.arguments as NewsModel;
      _isInit = false;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppString.newsDetails),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            // Why this need
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppFunction.verticalSpace(10),

              /// News article title
              Text(
                newsModel.title,
                style: AppTextStyle.titleTextStyle(context)
                    .copyWith(fontSize: 22.sp),
              ),
              AppFunction.verticalSpace(10),
              // Author and source row
              _buildAuthorSourceRow(),
              AppFunction.verticalSpace(5),
              // Image, bookmark, and share buttons
              _buildImageAndActions(),
              AppFunction.verticalSpace(10),
              // Content section header and body
              Text(AppString.content,
                  style: AppTextStyle.titleTextStyle(context)),
              AppFunction.verticalSpace(5),
              Text(
                newsModel.content,
                textAlign: TextAlign.justify,
                style: AppTextStyle.mediumTextStyle(context),
              ),
              AppFunction.verticalSpace(10),
              // Description section header and body
              Text(AppString.description,
                  style: AppTextStyle.titleTextStyle(context)),
              AppFunction.verticalSpace(5),
              Text(newsModel.description,
                  textAlign: TextAlign.justify,
                  style: AppTextStyle.mediumTextStyle(context)),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the row that displays the author and source of the news article.
  /// Shows empty space if author or source is missing.
  Row _buildAuthorSourceRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (newsModel.author.isNotEmpty)
          Expanded(
            child: Text(newsModel.author, style: AppTextStyle.authTextStyle),
          )
        else
          const SizedBox.shrink(),
        AppFunction.horizontalSpace(8),
        if (newsModel.source.isNotEmpty)
          Text(newsModel.source,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyle.sourceTextStyle)
        else
          const SizedBox.shrink(),
      ],
    );
  }

  /// Builds the news image with bookmark and share buttons overlay.
  /// Bookmark button toggles the saved state of the article.
  SizedBox _buildImageAndActions() {
    return SizedBox(
      height: .35.sh,
      width: 1.sw,
      child: Card(
        color: Theme.of(context).cardColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: .3.sh,
              width: 1.sw,
              child: Stack(
                children: [
                  // News image with rounded corners and hero animation
                  ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Hero(
                          tag: newsModel.publishedAt,
                          child: SafeNetworkImage(
                            height: 240,
                            isWidthFull: true,
                            imageUrl: newsModel.urlToImage,
                            boxFit: BoxFit.fill,
                          ))),
                  // Bookmark button at bottom-right
                  Positioned(
                      bottom: 0,
                      right: 10,
                      child: Consumer<BookmarksProvider>(
                          builder: (context, bookmarksProvider, _) {
                        final isBookmarked = bookmarksProvider
                            .isBookmarked(newsModel.publishedAt);
                        return _buildIconButton(
                            onTap: () async {
                              // Show loading while toggling bookmark state
                              AppFunction.showLoadingDialog(
                                context,
                                message: isBookmarked
                                    ? AppString.kRemovieBookmark
                                    : AppString.kSavingBookmark,
                              );
                              await bookmarksProvider.toggleBookmark(
                                  newsModel: newsModel);

                              if (!context.mounted) return;
                              Navigator.of(context).pop();
                            },
                            isBookmarked: isBookmarked,
                            icon: isBookmarked == true
                                ? Icons.bookmark
                                : Icons.bookmark_outline);
                      })),
                  Positioned(
                    bottom: 0,
                    right: 60,
                    child: _buildIconButton(
                      icon: Icons.share,
                      onTap: () => AppFunction.shareUrlWithErrorDialog(
                        context: context,
                        url: newsModel.url,
                      ),
                    ),
                  )
                ],
              ),
            ),
            // Row for website button and date
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    child: AppFunction.gotwebsiteMethod(context, newsModel.url,
                        const Color.fromARGB(255, 0, 2, 129))),
                Expanded(
                  child: Row(
                    children: [
                      Row(
                        children: [
                          AppFunction.cirledate(),
                          AppFunction.horizontalSpace(10),
                          Text(newsModel.datetoshow,
                              style: AppTextStyle.sourceTextStyle)
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Builds a circular icon button with shadow, used for actions like bookmarking.
  ///
  /// [onTap]     - Callback when the button is tapped.
  /// [icon]      - Icon to display inside the button.
  /// [isBookmarked] - Whether the icon represents a bookmarked state (changes color).
  Container _buildIconButton(
      {required VoidCallback onTap,
      required IconData icon,
      bool? isBookmarked = false}) {
    return Container(
      height: 43.h,
      width: 43.h,
      decoration: BoxDecoration(
          color: AppColors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
                color: AppColors.black.withOpacity(.5),
                spreadRadius: 1,
                blurRadius: 1.5,
                offset: const Offset(0.0, 0.75))
          ]),
      child: InkWell(
        onTap: onTap,
        child: Icon(
          icon,
          color: isBookmarked == true ? AppColors.red : AppColors.black,
        ),
      ),
    );
  }
}




/*
1. Using didChangeDependencies() is fine, but slightly less ideal for data that doesn't change later. However, because route arguments require context, we still use didChangeDependencies() here — just ensure it runs only once:
*/



/*
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  newsModel.author != null
                      ? Text(
                          newsModel!.author,
                          maxLines: 2,
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: AppColors.lightCardColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600)),
                        )
                      : Container(),
                  newsModel.source != null
                      ? Text(
                          newsModel!.source,
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: AppColors.deepred,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600)),
                        )
                      : Container()
                ],
              ),
  */


    /*
                              InkWell(
                                onTap: () async {
                                  if (isBooking) {
                                    bookmarksProvider.delete(
                                        publishedAt: newsModel!.publishedAt);
                                    setState(() {
                                      isBooking = false;
                                    });
                                  } else {
                                    DatabaseService.uploadFirebase(
                                        id: newsModel!.publishedAt,
                                        newsmodel: newsModel);
                                    setState(() {
                                      isBooking = true;
                                    });
                                  }
                                  await bookmarksProvider.fetchAllNews();
                                },
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black45,
                                            spreadRadius: 1,
                                            blurRadius: 1.5,
                                            offset: Offset(0.0, 0.75))
                                      ]),
                                  child: Icon(
                                    isBooking == true
                                        ? Icons.bookmark
                                        : Icons.bookmark_outline,
                                    color: isBooking == true
                                        ? AppColors.red
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            
                            */

                             /*
                                        if (isBooking) {
                                          bookmarksProvider.delete(
                                              publishedAt:
                                                  newsModel!.publishedAt);
                                          setState(() {
                                            isBooking = false;
                                          });
                                        } else {
                                          DatabaseService.uploadFirebase(
                                              id: newsModel!.publishedAt,
                                              newsmodel: newsModel);
                                          setState(() {
                                            isBooking = true;
                                          });
                                        }
                                        await bookmarksProvider.fetchAllNews();
                                  
                                  */

                                      // final bookmarksProvider = Provider.of<BookmarksProvider>(context);
    // final bookmarksProvider =
    //     Provider.of<BookmarksProvider>(context);
    // final bool isBookmarked =
    //     bookmarksProvider.isBookmarked(newsModel.publishedAt);

    /*
    final List<BookmarksModel> bookmarkList =
        Provider.of<BookmarksProvider>(context).getbookimarNewList;
    if (bookmarkList.isEmpty) {
      return;
    }
    List<BookmarksModel> currBookmark = bookmarkList
        .where((element) => element.publishedAt == newsModel?.publishedAt)
        .toList();
    if (currBookmark.isEmpty) {
      isBooking = false;
    } else {
      isBooking = true;
    }
*/