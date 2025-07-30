import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../res/app_colors.dart';
import '../../res/app_string.dart';
import '../../res/app_text_style.dart';
import '../../service/provider/search_provider.dart';

/// A reusable search input widget that interacts with [SearchProvider].
///
/// It handles user input for search queries and triggers search operations.
/// Also provides a clear button to reset the search input and results.

class SearchTextFieldWidget extends StatelessWidget {
  const SearchTextFieldWidget({super.key, required this.searchController});

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    // Obtain the SearchProvider instance without listening to changes,
    // to avoid unnecessary rebuilds in this widget.
    final searchProvider = Provider.of<SearchProvider>(context, listen: false);

    /// Performs a search based on the user's input query.
    ///
    /// Calls the provider's method to fetch results and sets the searching flag.
    Future<void> performSearch(String query) async {
      await searchProvider.searchNewsByQuery(query: query);
      searchProvider.setSearch(true);
    }

    /// Clears the search input and resets the provider's search results.
    void clearSearch() {
      searchController.clear(); // Why use clear############
      searchProvider.clearSearchResults(); // you'll add this method
    }

    return TextField(
      controller: searchController,
      textInputAction: TextInputAction.search,
      keyboardType: TextInputType.text,
      style: AppTextStyle.titleTextStyle(context),
      onSubmitted: performSearch,
      onChanged: performSearch,
      decoration: InputDecoration(
          hintText: AppString.searchHint,
          hintStyle: AppTextStyle.hintText,
          suffix: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.h),
            child: Padding(
              padding: EdgeInsets.only(right: 10.h),
              child: InkWell(
                onTap: clearSearch,
                child: Icon(
                  Icons.close,
                  color: AppColors.red,
                ),
              ),
            ),
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.black54, width: 1)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.red, width: 1))),
    );
  }
}
