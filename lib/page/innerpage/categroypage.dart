import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapps/model/newsmodel.dart';
import 'package:newsapps/service/apiservice.dart';
import 'package:provider/provider.dart';
import '../../const/globalcolors.dart';
import '../../widget/articlewidget.dart';
import '../../widget/loadingarticlewidget.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key, required this.categoryname});
  final String categoryname;

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final ScrollController _scrollController = ScrollController();

  List<NewsModel> categoryList = [];

  

  int limit = 10;
  bool _islimit = false;
  @override
  void initState() {
    getNews();
    super.initState();
  }
  @override
  void didChangeDependencies() {
    _scrollController.addListener(() async {
      if (limit == 80) {
        _islimit = true;
        setState(() {});
        return;
      }
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (kDebugMode) {
          print("_isLoading $_islimit");
        }

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
    categoryList = await ApiServices.getAllTopNews(
        pageSize: limit, category: widget.categoryname.toLowerCase());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: GlobalColors.black),
          backgroundColor: GlobalColors.white,
          elevation: 0.0,
          centerTitle: true,
          title: Text(
            "${widget.categoryname}  News",
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    color: GlobalColors.red,
                    fontSize: 16,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w800)),
          ),
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
                          child:  const ArticleItemWidget(),
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
