import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_exit_app/flutter_exit_app.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapps/const/globalcolors.dart';
import 'package:newsapps/page/innerpage/searchpage.dart';
import 'package:newsapps/service/newsprovider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../const/fontstyle.dart';
import '../../const/function.dart';
import '../../widget/drawerwidget.dart';
import '../../widget/shadermaskwidget.dart';
import '../../widget/singletabbarwidget.dart';
import 'alltopnews.dart';

class HomePage extends StatefulWidget {
  static const routeName = "/HomePage";
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 7, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context);
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        FlutterExitApp.exitApp();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: GlobalColors.black),
          backgroundColor: GlobalColors.white,
          elevation: 0.0,
          centerTitle: true,
          title: GlobalMethod.applogo(),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, SearchPage.routeName);
                  },
                  icon: Icon(
                    IconlyLight.search,
                    color: GlobalColors.black,
                    weight: 4,
                  )),
            )
          ],
        ),
        drawer: const DrawerWidget(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Top News", style: titleTextSTyle),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, AllTopNews.routeName);
                    },
                    child: Text("See All",
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: GlobalColors.black,
                                fontSize: 14,
                                letterSpacing: 1,
                                fontStyle: FontStyle.normal))),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 200,
                width: width,
                child: FutureBuilder(
                    future: newsProvider.fetchAllNews(page: 2),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey.shade200,
                          highlightColor: Colors.grey.shade400,
                          child: Container(
                            height: 200,
                            width: width,
                            color: Colors.grey.shade700,
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return GlobalMethod.errorMethod(
                            error: snapshot.error.toString());
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
              ),
              const SizedBox(
                height: 10,
              ),
              Text("All News", style: titleTextSTyle),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                height: 30,
                child: TabBar(
                  isScrollable: true,
                  labelStyle: tabLabelStyle,
                  unselectedLabelColor: Colors.black,
                  unselectedLabelStyle: tabunselectedLabelStyle,
                  labelColor: Colors.white,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: GlobalColors.red),
                  indicatorColor: Colors.transparent,
                  tabs: const [
                    Tab(
                      text: 'General',
                    ),
                    Tab(
                      text: 'Technology',
                    ),
                    Tab(
                      text: 'Sports',
                    ),
                    Tab(
                      text: 'Science',
                    ),
                    Tab(
                      text: 'Business',
                    ),
                    Tab(
                      text: 'Entertainment',
                    ),
                    Tab(
                      text: 'Health',
                    )
                  ],
                  controller: _tabController,
                  indicatorSize: TabBarIndicatorSize.tab,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: const [
                    SingleTabBarViewWidget(
                      text: 'General',
                    ),
                    SingleTabBarViewWidget(
                      text: 'Technology',
                    ),
                    SingleTabBarViewWidget(
                      text: 'Sports',
                    ),
                    SingleTabBarViewWidget(
                      text: 'Science',
                    ),
                    SingleTabBarViewWidget(
                      text: 'Business',
                    ),
                    SingleTabBarViewWidget(
                      text: 'Entertainment',
                    ),
                    SingleTabBarViewWidget(
                      text: 'Health',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
