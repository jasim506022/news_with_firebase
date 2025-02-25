import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapps/page/news/detailsnews.dart';
import 'package:provider/provider.dart';
import '../res/app_colors.dart';
import '../model/newsmodel.dart';
import '../page/news/detailsnewswebsite.dart';

class ShaderMaskWidget extends StatelessWidget {
  const ShaderMaskWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final newsmodelProvider = Provider.of<NewsModel>(context);
    double width = MediaQuery.of(context).size.width;
    return Material(
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
        child: Stack(
          children: [
            ShaderMask(
              // blendMode: BlendMode.dstIn,
              shaderCallback: (bounds) {
                return const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white,
                    Colors.black,
                  ],
                  stops: [.1, 1],
                ).createShader(
                    bounds); //Rect.fromLTRB(0, 0, bounds.width, bounds.height)
              },
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: FancyShimmerImage(
                    height: 200,
                    width: width,
                    boxFit: BoxFit.cover,
                    errorWidget: const Image(
                      image: AssetImage("asset/image/image.jpg"),
                      fit: BoxFit.fill,
                    ),
                    imageUrl: newsmodelProvider.urlToImage,
                  )), //"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSv6mzzZ-HDWrQfxdGhS2qUlhAsXElJJPlalg&usqp=CAU"
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(newsmodelProvider.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: AppColors.white,
                              fontSize: 17,
                              letterSpacing: 1.2,
                              fontWeight: FontWeight.w700))),
                  const SizedBox(
                    height: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailsNewsWebPage(
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
                      FittedBox(
                        child: Text(newsmodelProvider.datetoshow,
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: AppColors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal))),
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
