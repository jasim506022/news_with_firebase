import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../res/app_colors.dart';
import '../../res/app_function.dart';
import '../../res/app_string.dart';
import '../../res/app_text_style.dart';

/// A modal bottom sheet providing additional WebView actions:
/// - Share the URL
/// - Open the URL in an external browser
/// - Reload the current web page
class WebViewBottomActionsSheet extends StatelessWidget {
  const WebViewBottomActionsSheet(
      {super.key, required this.url, required this.controller});

  final String url;
  final WebViewController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Small handle bar at the top of the modal
          AppFunction.verticalSpace(10),
          Container(
            height: 7.h,
            width: 35.w,
            decoration: BoxDecoration(
                color: AppColors.grey,
                borderRadius: BorderRadius.circular(30.r)),
          ),
          // Title and Divider
          AppFunction.verticalSpace(15),
          Text(AppString.moreOption,
              style: AppTextStyle.titleTextStyle(context)),
          AppFunction.verticalSpace(10),
          const Divider(
            thickness: 3,
          ),
          AppFunction.verticalSpace(20),
          // Action: Share
          _buildActionTile(
              context: context,
              icon: Icons.share,
              title: AppString.share,
              onTap: () => AppFunction.shareUrlWithErrorDialog(
                  context: context, url: url)),
          // Action: Open in browser
          _buildActionTile(
            context: context,
            icon: Icons.open_in_browser,
            title: AppString.openInBrowser,
            onTap: () async {
              try {
                final uri = Uri.parse(url);
                if (!await launchUrl(uri)) {
                  throw Exception('Could not launch $url');
                }
              } catch (error) {
                AppFunction.toastMessage(error.toString());
              }
            },
          ),
          // Action: Refresh
          _buildActionTile(
            context: context,
            icon: Icons.refresh,
            title: AppString.refresh,
            onTap: () async {
              try {
                await controller.reload();
              } catch (error) {
                AppFunction.toastMessage(error.toString());
              }
            },
          ),
        ],
      ),
    );
  }

  /// Builds a reusable ListTile for each action option
  ListTile _buildActionTile(
      {required String title,
      required IconData icon,
      required VoidCallback onTap,
      required BuildContext context}) {
    return ListTile(
        leading: Icon(icon),
        title: Text(
          title,
          style: AppTextStyle.label(context),
        ),
        onTap: onTap);
  }
}
