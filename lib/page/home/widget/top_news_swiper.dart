import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../service/provider/news_provider.dart';
import '../../../widget/common_swiper_widget.dart';
import '../../../widget/no_data_placeholder.dart';
import '../../../loading/loading_placeholder_shader_mask_widget.dart';
import '../../../widget/news_shader_card.dart';

/// Displays a horizontally swipeable carousel of top news items.
/// Fetches data asynchronously and shows loading/error states.
class TopNewsSwiper extends StatelessWidget {
  const TopNewsSwiper({super.key});

  @override
  Widget build(BuildContext context) {
    // Access NewsProvider without listening to changes to avoid unnecessary rebuilds.
    final newsProvider = Provider.of<NewsProvider>(context, listen: false);
    return SizedBox(
      height: 220.h,
      width: 1.sw,
      child: FutureBuilder(
          future: newsProvider.fetchTopNews(page: 2),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingPlaceholderShaderMaskWidget();
            } else if (snapshot.hasError) {
              return const NoDataPlaceholder();
            }
            final newsList = snapshot.data ?? [];
            return CommonSwiperWidget(
              itemBuilder: (BuildContext context, int index) {
                // Provide individual news model to ShaderMaskWidget
                return ChangeNotifierProvider.value(
                    value: newsList[index], child: const NewsShaderCard());
              },
              itemCount: newsList.length.clamp(0, 8),
            );
          }),
    );
  }
}


/*
1. Why use Final
2. snapshot.data!.length.clamp(0, 8)
3. Where use futurebuilder and streambuilder
4. snapshot.data![index]

*/