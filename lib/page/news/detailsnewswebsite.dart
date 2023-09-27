import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapps/const/const.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../const/globalcolors.dart';

class DetailsNewsWebPage extends StatefulWidget {
  const DetailsNewsWebPage({super.key, required this.url});
  final String url;

  @override
  State<DetailsNewsWebPage> createState() => _DetailsNewsWebPageState();
}

class _DetailsNewsWebPageState extends State<DetailsNewsWebPage> {
  late WebViewController controller;
  bool loading = false;
  double progressValue = 0.0;

  @override
  void initState() {
    super.initState();

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
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await controller.canGoBack()) {
          controller.goBack();
          return false;
        }
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.black),
            backgroundColor: Colors.white,
            leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(IconlyLight.arrowLeft)),
            centerTitle: true,
            title: Text(
              widget.url,
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      color: GlobalColors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500)),
            ),
            actions: [
              IconButton(
                  onPressed: () async {
                    await _showModelSheetFct();
                  },
                  icon: const Icon(Icons.more_vert))
            ],
          ),
          body: Column(
            children: [
              LinearProgressIndicator(
                value: progressValue,
                color: progressValue == 1.0 ? Colors.transparent : Colors.red,
                backgroundColor: Colors.white,
              ),
              Expanded(
                child: WebViewWidget(
                  controller: controller,
                ),
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
              color: GlobalColors.white,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 15,
              ),
              Container(
                height: 5,
                width: 35,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(30)),
              ),
              const SizedBox(
                height: 15,
              ),
              Text("More Option",
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w800))),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                thickness: 3,
              ),
              const SizedBox(
                height: 20,
              ),
              ListTile(
                leading: const Icon(Icons.share),
                title: Text(
                  "Share",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: GlobalColors.black,
                          fontSize: 14,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w600)),
                ),
                onTap: () async {
                  try {
                    Share.share(widget.url, subject: 'Share The Url');
                  } catch (error) {
                    await globalMethod.errorDialog(
                        context: context, errorMessage: error.toString());
                  }
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.open_in_browser,
                ),
                title: Text("Open IN Browser",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: GlobalColors.black,
                            fontSize: 14,
                            letterSpacing: 1,
                            fontWeight: FontWeight.w600))),
                onTap: () async {
                  if (!await launchUrl(Uri.parse(widget.url))) {
                    throw Exception('Could not launch ${"url"}}');
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.refresh),
                title: Text(
                  "Refresh",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: GlobalColors.black,
                          fontSize: 14,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w600)),
                ),
                onTap: () async {
                  try {
                    //await controller.reload();
                  } catch (error) {
                    await globalMethod.errorDialog(
                        context: context, errorMessage: error.toString());
                  } finally {
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
