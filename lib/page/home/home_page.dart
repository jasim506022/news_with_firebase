import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../res/app_function.dart';
import '../../res/app_routes.dart';
import '../../res/app_string.dart';
import '../../res/app_text_style.dart';
import '../../res/const.dart';
import '../../service/other/api_service.dart';
import '../../widget/drawerwidget.dart';
import '../../widget/row_widget.dart';

import 'widget/singletabbarwidget.dart';
import '../news/searchpage.dart';
import 'widget/top_news_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 7, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        bool shouldPop = await showDialog<bool>(
              context: context,
              builder: (context) => AlertDialogWidget(
                title: AppString.exitDialogTitle,
                icon: Icons.question_mark,
                content: AppString.confirmExitMessage,
                onConfirmPressed: () => Navigator.of(context).pop(true),
                onCancelPressed: () => Navigator.of(context).pop(false),
              ),
            ) ??
            false;
        if (shouldPop) SystemNavigator.pop();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("${AppString.ju} ${AppString.news}"),
          actions: [
            Padding(
                padding: EdgeInsets.all(8.0.r),
                child: IconButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, SearchPage.routeName),
                    icon: const Icon(IconlyLight.search)))
          ],
        ),
        drawer: const DrawerWidget(),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.r),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppFunction.verticalSpace(8),
              RowWidget(
                  title: AppString.topNews,
                  onTap: () =>
                      Navigator.pushNamed(context, AppRoutes.allNewsPage)),
              AppFunction.verticalSpace(10),
              const TopNewsWidget(),
              AppFunction.verticalSpace(10),
              Text(AppString.allNews,
                  style: AppTextStyle.titleTextSTyle(context)),
              AppFunction.verticalSpace(10),
              SizedBox(
                  height: 40.sp,
                  child: TabBar(
                      isScrollable: true,
                      controller: tabController,
                      tabs: categories
                          .map((category) => Tab(text: category))
                          .toList())),
              AppFunction.verticalSpace(15),
              Expanded(
                  child: TabBarView(
                      controller: tabController,
                      children: categories
                          .map((category) =>
                              SingleTabBarViewWidget(text: category))
                          .toList())),
            ],
          ),
        ),
      ),
    );
  }
}

/*
Why use false in provider listen
*/
