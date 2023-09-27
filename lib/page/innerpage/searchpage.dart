import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapps/const/fontstyle.dart';
import 'package:newsapps/const/globalcolors.dart';
import 'package:newsapps/widget/articlewidget.dart';
import 'package:provider/provider.dart';
import '../../const/const.dart';
import '../../model/newsmodel.dart';
import '../../service/provider/newsprovider.dart';

class SearchPage extends StatefulWidget {
  static const routeName = "/Searchpage";
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
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: globalMethod.applogo(),
          ),
          body: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: TextField(
                  controller: _searchEditController,
                  textInputAction: TextInputAction.search,
                  keyboardType: TextInputType.text,
                  style: TextFontStyle.titleTextSTyle(context),
                  onSubmitted: (value) async {
                    searchList = await newsProvider.fetchASearchNews(
                        q: _searchEditController.text);
                  },
                  onChanged: (value) async {
                    searchList = await newsProvider.fetchASearchNews(
                        q: _searchEditController.text);
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
                              BorderSide(color: GlobalColors.red, width: 1))),
                ),
              ),
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
