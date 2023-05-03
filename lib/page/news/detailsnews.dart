import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapps/model/bookmarksmodel.dart';
import 'package:newsapps/page/news/detailsnewswebsite.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../const/function.dart';
import '../../const/globalcolors.dart';
import '../../model/newsmodel.dart';
import '../../service/bookmarksprovider.dart';
import '../../service/newsprovider.dart';

class NewsDetailsPage extends StatefulWidget {
  static const routeName = "/NewsDetailsPage";
  const NewsDetailsPage({super.key, required this.newsModel, });
  final dynamic newsModel;

  @override
  State<NewsDetailsPage> createState() => _NewsDetailsPageState();
}

class _NewsDetailsPageState extends State<NewsDetailsPage> {
  final firebasedatabase = FirebaseFirestore.instance.collection('News');
   dynamic newsModel;
  bool isBooking = false;
  String? publishedAt;
  dynamic currBookmark;
  bool isbookmarksLoading = true;

  @override
  void initState() {
    super.initState();
    newsModel = widget.newsModel;
  }

  @override
  void didChangeDependencies() {
    if (isbookmarksLoading) {
      final List<BookmarksModel> bookmarkList =
          Provider.of<BookmarksProvider>(context).getNewsList;
      if (bookmarkList.isEmpty) {
        return;
      }
      currBookmark = bookmarkList
          .where((element) => element.publishedAt == newsModel?.publishedAt)
          .toList();
      if (currBookmark.isEmpty) {
        isBooking = false;
      } else {
        isBooking = true;
      }
      isbookmarksLoading = false;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final newsProviders = Provider.of<NewsProvider>(context);
    //final newsModel = Provider.of<NewsModel>(context);
    final bookmarksProvider = Provider.of<BookmarksProvider>(context);

   // final newsModel = newsProviders.findByDate(publishedAt: publishedAt!);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: GlobalColors.black),
        backgroundColor: GlobalColors.white,
        centerTitle: true,
        title: GlobalMethod.applogo(),
        elevation: 1.15,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                newsModel!.title,
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: GlobalColors.black,
                        fontSize: 18,
                        height: 1.5,
                        fontWeight: FontWeight.w700)),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  newsModel!.author != null
                      ? Text(
                          newsModel!.author,
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: GlobalColors.gray,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600)),
                        )
                      : Container(),
                  newsModel!.source != null
                      ? Text(
                          newsModel!.source,
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: GlobalColors.deepred,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600)),
                        )
                      : Container()
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                height: height * .35,
                width: width,
                child: Card(
                  color: GlobalColors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: height * .3,
                        width: width,
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Hero(
                                tag: newsModel!.publishedAt,
                                child: FancyShimmerImage(
                                  imageUrl: newsModel!.urlToImage,
                                  height: height * .28,
                                  width: width,
                                  boxFit: BoxFit.fill,
                                  errorWidget: const Image(
                                      image:
                                          AssetImage("asset/image/image.jpg")),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 10,
                              child: InkWell(
                                onTap: () async {
                                  if (isBooking) {
                                    bookmarksProvider.delete(publishedAt: newsModel!.publishedAt);
                                    setState(() {
                                      isBooking = false;
                                    });
                                  } else {
                                    firebasedatabase
                                        .doc(newsModel!.publishedAt)
                                        .set(newsModel!.toMap());
                                    setState(() {
                                      isBooking = true;
                                    });
                                  }
                                  await bookmarksProvider.fetchAllNews();
                                },
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black45,
                                            spreadRadius: 1,
                                            blurRadius: 1.5,
                                            offset: Offset(0.0, 0.75))
                                      ]),
                                  child: Icon(
                                    isBooking == true
                                        ? Icons.bookmark
                                        : Icons.bookmark_outline,
                                    color: isBooking == true
                                        ? GlobalColors.red
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 60,
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black45,
                                          spreadRadius: 1,
                                          blurRadius: 1.5,
                                          offset: Offset(0.0, 0.75))
                                    ]),
                                child: InkWell(
                                  onTap: () async {
                                    try {
                                      Share.share(newsModel!.url,
                                          subject: 'Share The Url');
                                    } catch (error) {
                                      await GlobalMethod.errorDialog(
                                          context: context,
                                          errorMessage: error.toString());
                                    }
                                  },
                                  child: const Icon(
                                    Icons.share,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailsNewsWebPage(
                                        url: newsModel!.url,
                                      ),
                                    ));
                              },
                              child: const Icon(
                                Icons.link,
                                color: Color.fromARGB(255, 0, 88, 160),
                                size: 25,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 10,
                                      width: 10,
                                      decoration: BoxDecoration(
                                          color: GlobalColors.white,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              width: 3,
                                              color: GlobalColors.deepred)),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      newsModel!.datetoshow,
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              color: GlobalColors.deepred,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600)),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Content ",
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: GlobalColors.black,
                        fontSize: 16,
                        height: 1.2,
                        fontWeight: FontWeight.w700)),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                newsModel!.content,
                textAlign: TextAlign.justify,
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: GlobalColors.black,
                        fontSize: 15,
                        height: 1.5,
                        fontWeight: FontWeight.normal)),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                "Description ",
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: GlobalColors.black,
                        fontSize: 16,
                        height: 1.2,
                        fontWeight: FontWeight.w700)),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                newsModel!.description,
                textAlign: TextAlign.justify,
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: GlobalColors.black,
                        fontSize: 15,
                        height: 1.5,
                        fontWeight: FontWeight.normal)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
