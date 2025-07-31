import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../res/app_string.dart';
import '../../service/provider/search_provider.dart';
import '../../widget/article_item_widget.dart';
import '../../widget/no_results_widget.dart';
import 'search_text_field_widget.dart';

/// A page that allows users to search for news articles
class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    if (mounted) {
      _searchController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Access the SearchProvider instance
    final searchProvider = Provider.of<SearchProvider>(context);
    final isSearchingEmpty = searchProvider.hasSearched &&
        searchProvider.searchResults.isEmpty &&
        _searchController.text.trim().isNotEmpty;
    return GestureDetector(
      // Close the keyboard when tapping outside the input field
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(title: const Text(AppString.searchPage)),
          body: Column(
            children: [
              // Search input field
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child:
                    SearchTextFieldWidget(searchController: _searchController),
              ),
              // Show a prompt message when the input is empty
              if (_searchController.text.isEmpty)
                const Flexible(
                  child: NoResultsWidget(
                    title: AppString.kSearchPromptMessage,
                  ),
                ),
              // Show a "not found" message when the search is done but results are empty
              if (isSearchingEmpty)
                const Flexible(
                    child:
                        NoResultsWidget(title: AppString.kSearchPromptMessage)),
              // Show the list of search results
              if (searchProvider.searchResults.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    itemCount: searchProvider.searchResults.length,
                    itemBuilder: (context, index) {
                      final newsModel = searchProvider.searchResults[index];
                      return ChangeNotifierProvider.value(
                        value: newsModel,
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

/*
  Future<void> handSearch(String query) async {
    final newsProvider = Provider.of<NewsProvider>(context, listen: false);
    _searchResults =
        await newsProvider.fetchSearchResults(query: _searchController.text);
    newsProvider.setSearch(true);
    setState(() {}); // Update UI with search results
  }

  // Clears the search field and search result
  void clearSearch() {
    _searchController.clear();
    _searchResults?.clear();
    Provider.of<NewsProvider>(context, listen: false).setSearch(false);
    setState(() {});
  }
*/