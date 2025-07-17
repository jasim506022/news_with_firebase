import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';
import '../res/app_colors.dart';
import '../model/news_model_.dart';
import '../res/app_function.dart';
import '../res/app_routes.dart';
import '../res/app_text_style.dart';
import 'safe_network_image.dart';

/// A news card with a background image, gradient overlay, and footer text.
///
/// The card is tappable and navigates to the detailed news page using [Hero] animation.
/// It also includes a link icon to open the full article in a web view.

class NewsShaderCard extends StatelessWidget {
  const NewsShaderCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final news = Provider.of<NewsModel>(context);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, AppRoutes.newsDetailsPage,
            arguments: news),
        child: Stack(
          children: [
            // Background image with gradient and Hero animation
            _buildHeroImageWithGradient(news.urlToImage, news.publishedAt),
            Positioned(
              bottom: 10.h,
              left: 10.w,
              right: 10.w,
              child: _buildOverlayFooter(context, news),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the background image with a black-to-white vertical gradient overlay.
  Widget _buildHeroImageWithGradient(String imageUrl, String tag) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [AppColors.white, AppColors.black],
        stops: const [0.1, 1.0],
      ).createShader(bounds),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(15.r),
          child: Hero(
            tag: tag,
            child: SafeNetworkImage(
              imageUrl: imageUrl,
              isWidthFull: true,
              boxFit: BoxFit.cover,
              height: 220,
              width: 1,
            ),
          )),
    );
  }

  /// Builds the title, link icon, and date row.
  Widget _buildOverlayFooter(BuildContext context, NewsModel news) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          news.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyle.titleTextStyle(context).copyWith(
            color: AppColors.white,
            letterSpacing: 1.2,
          ),
        ),
        AppFunction.verticalSpace(2),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () => Navigator.pushNamed(
                context,
                AppRoutes.detailsNewsWebPage,
                arguments: news.url,
              ),
              child: Icon(Icons.link, color: AppColors.red),
            ),
            Flexible(
              child: Text(
                news.datetoshow,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.mediumBoldTextStyle(context)
                    .copyWith(color: AppColors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }
}



/*
// understand this code
LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white,
                    Colors.black,
                  ],
                  stops: [.1, 1],
                ).createShader(bounds);
              },


               Why Use Private Methods Instead of Widgets?
✅ Use Method When...	❌ Don't Use Method When...
Logic/UI is specific to this widget only	The logic/UI will be reused elsewhere
You want to reduce visual clutter	You need separate build context
You want better separation without extra files	You want testable or deeply nested components
*/




/*

            /*
            ShaderMask(
              shaderCallback: (bounds) {
                return const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white,
                    Colors.black,
                  ],
                  stops: [.1, 1],
                ).createShader(bounds);
              },
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: FancyShimmerImage(
                    height: 220.h,
                    width: 1.sw,
                    boxFit: BoxFit.cover,
                    errorWidget: const Image(
                        image: AssetImage(AppImages.emptyImage),
                        fit: BoxFit.fill),
                    imageUrl: newsModel.urlToImage,
                  )),
            ),
            
            
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
              // Understand column
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(newsModel.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.titleTextSTyle(context).copyWith(
                          color: AppColors.white, letterSpacing: 1.2)),
                  AppFunction.verticalSpace(2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                          onTap: () => Navigator.pushNamed(
                              context, AppRoutes.detailsNewsWebPage,
                              arguments: newsModel.url),
                          child: Icon(Icons.link, color: AppColors.red)),
                      FittedBox(
                        child: Text(newsModel.datetoshow,
                            style: AppTextStyle.mediumBoldTextStyle(context)
                                .copyWith(color: AppColors.white)),
                      )
                    ],
                  )
                ],
              ),
            )
          */
          
*/

/*
 //     FancyShimmerImage(
        //   height: 220.h,
        //   width: 1.sw,
        //   boxFit: BoxFit.cover,
        //   imageUrl: imageUrl,
        //   errorWidget: const Image(
        //     image: AssetImage(AppImages.emptyImage),
        //     fit: BoxFit.fill,
        //   ),
        // ),
*/