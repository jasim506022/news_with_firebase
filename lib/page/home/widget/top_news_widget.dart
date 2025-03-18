import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsapps/widget/error_widget.dart';
import 'package:provider/provider.dart';

import '../../../service/provider/news_provider.dart';
import '../../../widget/shader_mask_widget.dart';
import '../../../widget/shimmer_auth_widget.dart';

class TopNewsWidget extends StatelessWidget {
  const TopNewsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context);
    return SizedBox(
      height: 220.h,
      width: 1.sw,
      child: FutureBuilder(
          future: newsProvider.fetchAllTopNews(page: 2),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const ShimmerAutoWidget();
            } else if (snapshot.hasError) {
              return const ErrorNullWidget();
            }
            return Swiper(
              itemBuilder: (BuildContext context, int index) {
                return ChangeNotifierProvider.value(
                  value: snapshot.data![index],
                  child: const ShaderMaskWidget(),
                );
              },
              scale: .8,
              itemCount: 8,
              viewportFraction: .98,
              layout: SwiperLayout.DEFAULT,
              autoplay: true,
              autoplayDelay: 3000,
            );
          }),
    );
  }
}
