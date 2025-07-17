import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

/// A reusable swiper/carousel widget using [Swiper] from card_swiper package.
///
/// It accepts a builder and item count, and handles layout and autoplay.
class CommonSwiperWidget extends StatelessWidget {
  const CommonSwiperWidget({
    super.key,
    required this.itemBuilder,
    required this.itemCount,
  });
  // final Widget widget;
  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Swiper(
      itemBuilder: itemBuilder,
      scale: .8,
      itemCount: itemCount,
      viewportFraction: .95,
      layout: SwiperLayout.DEFAULT,
      autoplay: true,
      autoplayDelay: 3000,
    );
  }
}

// Support different layouts (SwiperLayout.STACK, SwiperLayout.TINDER) via a layout parameter
// understand itemBuilder
