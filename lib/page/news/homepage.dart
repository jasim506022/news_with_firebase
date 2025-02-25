import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:newsapps/res/const.dart';
import 'package:newsapps/res/app_colors.dart';
import 'package:newsapps/page/innerpage/searchpage.dart';
import 'package:newsapps/service/provider/newsprovider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../res/app_text_style.dart';
import '../../widget/drawerwidget.dart';
import '../../widget/rowwidget.dart';
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
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: globalMethod.applogo(),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, SearchPage.routeName);
                  },
                  icon: Icon(IconlyLight.search,
                      color: Theme.of(context).iconTheme.color)),
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
              const SizedBox(
                height: 8,
              ),
              RowWidget(
                  title: "Top News",
                  function: () {
                    Navigator.pushNamed(context, AllTopNews.routeName);
                  }),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 200,
                width: width,
                child: FutureBuilder(
                    future: newsProvider.fetchAllTopNews(page: 2),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey.shade200,
                          highlightColor: Colors.grey.shade400,
                          child: Container(
                            height: 200,
                            width: width,
                            color: Theme.of(context).cardColor,
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return globalMethod.errorMethod(
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
              Text("All News", style: AppTextStyle.titleTextSTyle(context)),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                height: 30,
                child: TabBar(
                  isScrollable: true,
                  labelStyle: tabLabelStyle,
                  unselectedLabelColor: Theme.of(context).iconTheme.color,
                  unselectedLabelStyle: tabunselectedLabelStyle,
                  labelColor: Colors.white,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.red),
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
