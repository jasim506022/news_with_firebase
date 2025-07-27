import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../res/app_colors.dart';
import '../../res/app_function.dart';
import '../../res/app_string.dart';
import '../../res/app_text_style.dart';

class DetailsNewsWebPage extends StatefulWidget {
  const DetailsNewsWebPage({
    super.key,
  });

  @override
  State<DetailsNewsWebPage> createState() => _DetailsNewsWebPageState();
}

class _DetailsNewsWebPageState extends State<DetailsNewsWebPage> {
  late WebViewController controller;
  // bool loading = false;
  // double progressValue = 0.0;
  late String url;

  // late final WebViewController _controller;
  // late String _url;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Retrieve the URL passed as route argument
    url = ModalRoute.of(context)?.settings.arguments as String;

    final webViewProgressProvider =
        Provider.of<WebViewProgressProvider>(context, listen: false);

    // Initialize WebView controller and listen for navigation events
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update progress via provider (0.0 to 1.0)
            webViewProgressProvider.setProgress(progress / 100);
          },
          onPageStarted: (String url) {
            // Could show loading indicator if needed
          },
          onPageFinished: (String url) {
            // Page load finished
          },
          onWebResourceError: (WebResourceError error) {
            // Handle web resource errors
          },
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
    return PopScope(
      canPop: false, // when use use false and when use true
      onPopInvoked: (didPop) async {
        if (!didPop && await controller.canGoBack()) {
          // যদি Flutter নিজে pop না করে এবং WebView-এ back যাওয়ার history থাকে
          await controller.goBack();
        } else if (!await controller.canGoBack()) {
          // WebView-এ back যাওয়ার কিছু না থাকলে → pop করো
          Navigator.of(context).maybePop();
        }
      },
      child: Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.black),
            leading: InkWell(
                onTap: () => Navigator.pop(context),
                child: const Icon(IconlyLight.arrowLeft)),
            title: Text(
              url,
              style: AppTextStyle.appBarTextStyle,
            ),
            actions: [
              IconButton(
                  onPressed: () async => await _showModelSheetFct(),
                  icon: const Icon(Icons.more_vert))
            ],
          ),
          body: Column(
            children: [
              Consumer<WebViewProgressProvider>(
                builder: (context, value, child) => LinearProgressIndicator(
                  value: value.progress,
                  color:
                      value.progress == 1.0 ? Colors.transparent : Colors.red,
                  backgroundColor: Colors.white,
                ),
              ),
              Expanded(
                child: WebViewWidget(controller: controller),
              ),
            ],
          )),
    );
  }

  Future<void> _showModelSheetFct() async {
    await showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppFunction.verticalSpace(10),
              Container(
                height: 5,
                width: 35,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(30)),
              ),
              AppFunction.verticalSpace(15),
              Text(AppString.moreOption,
                  style: AppTextStyle.titleTextStyle(context)),
              AppFunction.verticalSpace(10),
              const Divider(
                thickness: 3,
              ),
              AppFunction.verticalSpace(20),
              _buildListTile(
                  icon: Icons.share,
                  title: AppString.share,
                  onTap: () => AppFunction.shareUrlWithErrorDialog(
                      context: context, url: url)),
              _buildListTile(
                icon: Icons.open_in_browser,
                title: AppString.openInBrowser,
                onTap: () async {
                  try {
                    final uri = Uri.parse(url);
                    if (!await launchUrl(uri)) {
                      throw Exception('Could not launch $url');
                    }
                  } catch (error) {
                    _showErrorDialog(error.toString());
                  }
                },
              ),
              _buildListTile(
                icon: Icons.refresh,
                title: AppString.refresh,
                onTap: () async {
                  try {
                    await controller.reload();
                  } catch (error) {
                    _showErrorDialog(error.toString());
                  } finally {
                    if (context.mounted) Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showErrorDialog(String message) {
    if (!mounted) return;

    showDialog(
      context: context,
      builder: (_) => ErrorDialog(title: message),
    );
  }

  ListTile _buildListTile(
      {required String title,
      required IconData icon,
      required VoidCallback onTap}) {
    return ListTile(
        leading: Icon(icon),
        title: Text(
          title,
          style: AppTextStyle.label(context),
        ),
        onTap: onTap);
  }
}

/// Provider class to manage WebView loading progress and loading state
class WebViewProgressProvider extends ChangeNotifier {
  double _progress = 0.0;

  double get progress => _progress;

  /// Set loading progress [value] between 0.0 and 1.0
  void setProgress(double value) {
    _progress = value;
    notifyListeners();
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