import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapps/const/const.dart';
import 'package:newsapps/service/provider/newsprovider.dart';
import 'package:provider/provider.dart';

import '../../const/globalcolors.dart';
import '../../service/other/apiservice.dart';
import '../../widget/articlewidget.dart';
import '../../widget/loadingarticlewidget.dart';

class AllTopNews extends StatefulWidget {
  static const routeName = "/AllNewsPage";
  const AllTopNews({super.key});


  @override
  State<AllTopNews> createState() => _AllTopNewsState();
}

class _AllTopNewsState extends State<AllTopNews> {

@override
  void initState() {
    Future.delayed(Duration.zero, () {
      Provider.of<NewsProvider>(context, listen: false).setCurrentIndex(0);
    },);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('All TopNews'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: kBottomNavigationBarHeight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  globalMethod.paginationButton(
                    text: 'Pre',
                    function: () {
                      if (newsProvider.currentindex == 0) {
                        return;
                      }
                      newsProvider.removeCurrentIndex();
                    },
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: 20,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Material(
                            color: newsProvider.currentindex == index
                                ? GlobalColors.red
                                : Colors.white,
                            child: InkWell(
                              onTap: () {
                                newsProvider.setCurrentIndex(index);
                              },
                              child: Center(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "${(index + 1)}",
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color:
                                              newsProvider.currentindex == index
                                                  ? GlobalColors.white
                                                  : GlobalColors.black,
                                          fontSize: 15,
                                          letterSpacing: 1,
                                          fontWeight: FontWeight.w800)),
                                ),
                              )),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  globalMethod.paginationButton(
                    text: 'Next',
                    function: () {
                      if (newsProvider.currentindex == 19) {
                        return;
                      }
                      newsProvider.addCurrentIndex();
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future:
                    ApiServices.getAllTopNews(page: newsProvider.currentindex + 1),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const LoadingArticleWidget();
                  } else if (snapshot.hasError) {
                    return globalMethod.errorMethod(
                        error: snapshot.error.toString());
                  } else if (!snapshot.hasData) {
                    return Image.asset("asset/image/nonewsitemfound.png");
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return ChangeNotifierProvider.value(
                        value: snapshot.data![index],
                        child: const ArticleItemWidget(),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
