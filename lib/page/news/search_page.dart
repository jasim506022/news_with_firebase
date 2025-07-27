import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';
import '../../model/news_model_.dart';
import '../../res/app_colors.dart';
import '../../res/app_string.dart';
import '../../res/app_text_style.dart';
import '../../service/provider/news_provider.dart';
import '../../widget/article_item_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchEditController = TextEditingController();

  List<NewsModel>? searchList = [];

  @override
  void dispose() {
    if (mounted) {
      _searchEditController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context, listen: true);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(title: const Text(AppString.homeAppBarTitle)),
          body: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: TextField(
                  controller: _searchEditController,
                  textInputAction: TextInputAction.search,
                  keyboardType: TextInputType.text,
                  style: AppTextStyle.titleTextStyle(context),
                  onSubmitted: (value) async {
                    searchList = await newsProvider.fetchSearchResults(
                        query: _searchEditController.text);
                  },
                  onChanged: (value) async {
                    searchList = await newsProvider.fetchSearchResults(
                        query: _searchEditController.text);
                    newsProvider.setSearch(true);
                  },
                  decoration: InputDecoration(
                      hintText: "Search Here",
                      hintStyle: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              letterSpacing: 1,
                              fontWeight: FontWeight.w600)),
                      contentPadding:
                          const EdgeInsets.only(bottom: 8 / 5, left: 10),
                      suffix: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            right: 10,
                          ),
                          child: InkWell(
                            onTap: () {
                              _searchEditController.clear();
                              searchList!.clear();
                              newsProvider.setSearch(false);
                            },
                            child: const Icon(
                              Icons.close,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: Colors.black54, width: 1)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(color: AppColors.red, width: 1))),
                ),
              ),
              if (_searchEditController.text.isEmpty)
                Flexible(
                    child: Center(
                        child: Image.asset("asset/image/nonewsitemfound.png"))),
              if (newsProvider.isSearch && searchList!.isEmpty)
                Flexible(
                    child: Center(
                        child: Image.asset("asset/image/nonewsitemfound.png"))),
              if (searchList != null && searchList!.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    itemCount: searchList!.length,
                    itemBuilder: (context, index) {
                      return ChangeNotifierProvider.value(
                        value: searchList![index],
                        child: const ArticleItemWidget(),
                      );
                    },
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
