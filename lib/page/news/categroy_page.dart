import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../service/provider/news_provider.dart';
import '../../widget/article_item_widget.dart';
import '../../loading/loading_articles_list_widget.dart';

/*
class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final ScrollController _scrollController = ScrollController();

  List<NewsModel> _articles = [];
  late String _category;
  int _limit = 10;
  bool _isEndReached = false;
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _category = ModalRoute.of(context)?.settings.arguments as String;
    _fetchArticles();

    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isEndReached || _isLoading) return;

    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent) {
      _limit += 10;
      _fetchArticles();
    }
  }

  Future<void> _fetchArticles() async {
    setState(() => _isLoading = true);

final newsProvider = Provider.of<NewsProvider>(context);

newsProvider.fetchNewsByCategory(pageSize:_limit , category: _category.toLowerCase());
    // final fetched = await ApiServices.fetchNewsByCategory(
    //   pageSize: _limit,
    //   category: _category.toLowerCase(),
    // );

    setState(() {
      _articles = fetched;
      _isLoading = false;
      if (fetched.length < _limit) _isEndReached = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_category)),
      body: _articles.isEmpty
          ? const LoadingArticleWidget()
          : SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  ListView.builder(
                    itemCount: _articles.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ChangeNotifierProvider.value(
                        value: _articles[index],
                        child: const ArticleItemWidget(),
                      );
                    },
                  ),
                  if (!_isEndReached && _isLoading)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: CircularProgressIndicator(color: Colors.red),
                    ),
                ],
              ),
            ),
    );
  }
}

*/

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final ScrollController _scrollController = ScrollController();
  late String _category;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _category = ModalRoute.of(context)?.settings.arguments as String;
    final provider = Provider.of<NewsProvider>(context, listen: false);
    provider.reset();
    provider.fetchNewsByCategorya(category: _category);

    _scrollController.addListener(() {
      final provider = Provider.of<NewsProvider>(context, listen: false);
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent &&
          !provider.isEndReached &&
          !provider.isLoading) {
        provider.fetchNewsByCategorya(
          category: _category,
          isLoadMore: true,
        );
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NewsProvider>(
      builder: (context, provider, _) {
        return Scaffold(
          appBar: AppBar(title: Text(_category)),
          body: provider.newsList.isEmpty && provider.isLoading
              ? const LoadingArticleWidget()
              : SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: provider.newsList.length,
                        itemBuilder: (context, index) {
                          return ChangeNotifierProvider.value(
                            value: provider.newsList[index],
                            child: const ArticleItemWidget(),
                          );
                        },
                      ),
                      if (!provider.isEndReached && provider.isLoading)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: CircularProgressIndicator(color: Colors.red),
                        ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}


/*

class CateoryPage extends StatefulWidget {
  const CateoryPage({
    super.key,
  });

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
    final fetchedNews = await ApiServices.fetchNewsByCategory(
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
          title: Text(categoryName),
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

*/
