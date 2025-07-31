import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../res/app_images.dart';

/// A robust image widget that safely displays a network image.
/// Falls back to a local placeholder if the URL is null or invalid.
class SafeNetworkImage extends StatelessWidget {
  const SafeNetworkImage(
      {super.key,
      required this.imageUrl,
      required this.height,
      this.width = 1,
      this.boxFit = BoxFit.cover,
      this.isWidthFull = false});

  /// Checks if the given URL is valid for network usage.
  final String imageUrl;
  final double height;
  final double width;
  final BoxFit boxFit;
  final bool isWidthFull;

  @override
  Widget build(BuildContext context) {
    // Helper to validate the image URL format
    bool isValidUrl(String? url) {
      if (url == null || url.isEmpty) return false;
      return url.startsWith('http://') || url.startsWith('https://');
    }

// Placeholder shown when URL is invalid or image loading fails
    final placeholder = Image(
      image: const AssetImage(AppImages.emptyImage),
      height: height.h,
      width: isWidthFull ? width.sw : width.w,
      fit: BoxFit.fill,
    );

    // Return network image with shimmer effect if URL valid, else placeholder
    return isValidUrl(imageUrl)
        ? FancyShimmerImage(
            imageUrl: imageUrl,
            height: height.h,
            width: isWidthFull ? width.sw : width.w,
            boxFit: boxFit,
            errorWidget: placeholder,
          )
        : placeholder;
  }
}


/*
FancyShimmerImage(
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


/*

bool _isValidUrl(String? url) {
    if (url == null || url.isEmpty) return false;
    return url.startsWith('http://') || url.startsWith('https://');
  }


bool get _hasValidUrl =>
      imageUrl != null &&
      imageUrl!.isNotEmpty &&
      (imageUrl!.startsWith('http://') || imageUrl!.startsWith('https://'));

      Improves readability and makes it more "Flutter-y".

*/