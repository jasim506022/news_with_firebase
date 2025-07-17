import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../res/app_function.dart';
import '../../res/app_routes.dart';
import '../../res/app_string.dart';
import '../../res/app_text_style.dart';
import '../../res/app_constant.dart';
import '../drawer/app_drawer.dart';
import '../../widget/section_header_widget.dart';

import 'widget/category_news_tab_view.dart';
import 'widget/top_news_swiper.dart';

/// The main home screen of the app.
///
/// It includes:
/// - An app bar with a search button
/// - A navigation drawer
/// - A top news section
/// - Category-based tabbed news section

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  /// Controls which tab (category) is currently selected.
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // Initialize the tab controller with the number of categories
    _tabController =
        TabController(length: AppConstant.categoryLength, vsync: this);
  }

  @override
  void dispose() {
    // Always dispose controllers to free resources
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        // Show confirmation dialog before exiting the app
        bool shouldExit =
            await AppFunction.showExitConfirmationDialog(context) ?? false;
        if (shouldExit) SystemNavigator.pop();
      },
      child: Scaffold(
        appBar: _buildAppBar(),
        drawer: AppDrawer(),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppFunction.verticalSpace(8),

              // Section header for "Top News" with a "See All" button
              SectionHeaderRow(
                  title: AppString.topNews,
                  onTap: () =>
                      Navigator.pushNamed(context, AppRoutes.allNewsPage)),
              AppFunction.verticalSpace(10),

              // Swiper (carousel) showing top news headlines
              const TopNewsSwiper(),
              AppFunction.verticalSpace(10),

              /// "All News" title
              Text(AppString.allNews,
                  style: AppTextStyle.titleTextStyle(context)),
              AppFunction.verticalSpace(10),

              // Scrollable tab bar showing all news categories
              SizedBox(
                  height: 40.sp,
                  child: TabBar(
                      isScrollable: true,
                      controller: _tabController,
                      tabs: AppConstant.categories
                          .map((category) => Tab(text: category))
                          .toList())),
              AppFunction.verticalSpace(15),

              // Displays news content based on the selected category tab
              Expanded(
                  child: TabBarView(
                      controller: _tabController,
                      children: AppConstant.categories
                          .map((category) =>
                              CategoryNewsTabView(categoryLabel: category))
                          .toList())),
            ],
          ),
        ),
      ),
    );
  }

  /// Creates the AppBar with a title and search icon button.
  AppBar _buildAppBar() {
    return AppBar(title: const Text(AppString.homeAppBarTitle), actions: [
      Padding(
          padding: EdgeInsets.all(8.0.r),
          child: IconButton(
              onPressed: () =>
                  Navigator.pushNamed(context, AppRoutes.searchPage),
              icon: const Icon(IconlyLight.search)))
    ]);
  }
}





/*
1. Which comments use // or // where and why 
2. Why is best than it 
1.  bool shouldExit =
            await AppFunction.showExitConfirmationDialog(context) ?? false;
        if (shouldExit) SystemNavigator.pop();
        2. final shouldExit = await AppFunction.showExitConfirmationDialog(context);
if (shouldExit ?? false) SystemNavigator.pop();

3.
*/

/*
flutter concise, readable maintainable, efficient and easy way to understand others programmer and also good name variable , class and method . also add good comments for understand . if change anything where and why change
*/
