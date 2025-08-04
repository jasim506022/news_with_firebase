import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

import 'package:webview_flutter/webview_flutter.dart';
import '../../res/app_colors.dart';

import '../../res/app_text_style.dart';
import '../../service/provider/web_view_progress_provider.dart';
import 'web_view_bottom_action_sheet.dart';

/// Page displaying a WebView to show detailed news web content.
/// Includes navigation controls and a bottom modal sheet for extra actions.
class WebViewNewsPage extends StatefulWidget {
  const WebViewNewsPage({
    super.key,
  });

  @override
  State<WebViewNewsPage> createState() => _WebViewNewsPageState();
}

class _WebViewNewsPageState extends State<WebViewNewsPage> {
  late WebViewController webViewController;

  late String url;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Retrieve URL passed via route arguments only once
    url = ModalRoute.of(context)?.settings.arguments as String;

    final webViewProgressProvider =
        Provider.of<WebViewProgressProvider>(context, listen: false);

    // Setup WebView controller and navigation delegate for progress and restrictions
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) =>
              // Update progress via provider (0.0 to 1.0)
              webViewProgressProvider.setProgress(progress / 100),
          onNavigationRequest: (NavigationRequest request) {
            // Prevent navigation to certain domains
            if (request.url.startsWith('https://www.bd-pratidin.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(url));
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        // Handle back navigation inside WebView
        if (await webViewController.canGoBack()) {
          await webViewController.goBack();
          return false;
        }
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: AppColors.black),
            leading: InkWell(
                onTap: () => Navigator.of(context).pop(),
                child: const Icon(IconlyLight.arrowLeft)),
            title: Text(
              url,
              style: AppTextStyle.appBarTextStyle,
            ),
            actions: [
              IconButton(
                  onPressed: () async => await showModalBottomSheet(
                        context: context,
                        builder: (context) => WebViewBottomActionsSheet(
                            url: url, controller: webViewController),
                      ),
                  icon: const Icon(Icons.more_vert))
            ],
          ),
          body: Column(
            children: [
              // Display loading progress bar
              Consumer<WebViewProgressProvider>(
                builder: (context, progressProvider, _) =>
                    LinearProgressIndicator(
                  value: progressProvider.progress,
                  color: progressProvider.progress == 1.0
                      ? Colors.transparent
                      : AppColors.red,
                  backgroundColor: AppColors.white,
                ),
              ),
              // Load the WebView
              Expanded(child: WebViewWidget(controller: webViewController)),
            ],
          )),
    );
  }
}




/*
  @override
  void initState() {
    super.initState();
    url = ModalRoute.of(context)?.settings.arguments as String;
    loading = true;

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            setState(() {
              progressValue = (progress / 100);
            });
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.bd-pratidin.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(url));
  }
  */

/*
  WillPopScope(
      onWillPop: () async {
        if (await controller.canGoBack()) {
          controller.goBack();
          return false;
        }
        return true;
      },
  */




/*
    url = ModalRoute.of(context)?.settings.arguments as String;
    loading = true;

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            setState(() {
              progressValue = (progress / 100);
            });
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.bd-pratidin.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(url));

      */