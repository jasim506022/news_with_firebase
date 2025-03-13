import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsapps/res/app_images.dart';
import 'package:newsapps/res/app_routes.dart';
import 'package:newsapps/res/app_text_style.dart';
import 'package:provider/provider.dart';
import '../res/app_colors.dart';
import '../model/news_model_.dart';

class ShaderMaskWidget extends StatelessWidget {
  const ShaderMaskWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final newsModel = Provider.of<NewsModel>(context);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, AppRoutes.newsDetailsPage,
            arguments: newsModel),
        child: Stack(
          children: [
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
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(newsModel.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.titleTextSTyle(context).copyWith(
                          color: AppColors.white, letterSpacing: 1.2)),
                  SizedBox(height: 2.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, AppRoutes.detailsNewsWebPage,
                                arguments: newsModel.url);
                          },
                          child: Icon(
                            Icons.link,
                            color: AppColors.red,
                          )),
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
          ],
        ),
      ),
    );
  }
}
