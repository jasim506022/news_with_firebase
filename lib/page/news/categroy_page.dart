import 'package:flutter/material.dart';
import 'package:newsapps/model/news_model_.dart';
import 'package:provider/provider.dart';
import '../../service/other/api_service.dart';
import '../../widget/article_item_widget.dart';
import '../../widget/loadingarticlewidget.dart';

class CateoryPage extends StatefulWidget {
  const CateoryPage({
    super.key,
    //  required this.categoryName
  });
  // final String categoryName;

  @override
  State<CateoryPage> createState() => _CateoryPageState();
}

class _CateoryPageState extends State<CateoryPage> {
  final ScrollController _scrollController = ScrollController();

  List<NewsModel> categoryList = [];

  int limit = 10;
  bool _islimit = false;

  late String categoryName;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    categoryName = ModalRoute.of(context)?.settings.arguments as String;
    getNews();
    _scrollController.addListener(() async {
      if (limit == 80) {
        _islimit = true;
        setState(() {});
        return;
      }
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        limit += 10;

        await getNews();
      }
    });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> getNews() async {
    final fetchedNews = await ApiServices.getAllNews(
        pageSize: limit, category: categoryName.toLowerCase());
    if (fetchedNews.length < limit) {
      _islimit = true;
    }
    // Add the fetched news to the list
    setState(() {
      categoryList = fetchedNews;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("$categoryName News"),
        ),
        body: categoryList.isEmpty
            ? const LoadingArticleWidget()
            : SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: categoryList.length,
                      itemBuilder: (context, index) {
                        return ChangeNotifierProvider.value(
                          value: categoryList[index],
                          child: const ArticleItemWidget(),
                        );
                      },
                    ),
                    if (!_islimit)
                      const Center(
                          child: CircularProgressIndicator(
                        color: Colors.red,
                      )),
                  ],
                ),
              ));
  }
}
