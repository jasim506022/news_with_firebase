import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../../model/news_model_.dart';
import '../../res/app_string.dart';
import '../../service/provider/bookmarksprovider.dart';
import '../../widget/article_item_widget.dart';
import '../../widget/confirmation_dialog.dart';
import '../../widget/no_results_widget.dart';

/// Page that displays all bookmarked news articles.
/// Allows users to view and clear all bookmarks.
class BookmarksPage extends StatefulWidget {
  const BookmarksPage({super.key});

  @override
  State<BookmarksPage> createState() => _BookmarksPageState();
}

class _BookmarksPageState extends State<BookmarksPage> {
  @override
  void initState() {
    // Fetch all bookmarks when this page is initialized
    Provider.of<BookmarksProvider>(context, listen: false).fetchAllBookmarks();
    super.initState();
  }

  /// Shows a confirmation dialog before deleting all bookmarks.
  /// If user confirms, it clears all bookmarks via provider.
  Future<void> _handleDeleteAllBookmarks(BuildContext context) async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => ConfirmationDialog(
        dialogIcon: Icons.delete,
        dialogTitle: AppString.kDeleteAllBookmarksTitle,
        message: AppString.kDeleteAllBookmarksMessage,
        onCancel: () => Navigator.pop(context, false),
        onConfirm: () => Navigator.pop(context, true),
      ),
    );

    if (confirmed == true) {
      // Access provider without listening (to avoid rebuild on this call)
      if (!context.mounted) return;
      final bookmarksProvider =
          Provider.of<BookmarksProvider>(context, listen: false);
      await bookmarksProvider.clearAllBookmarks();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppString.bookmarkTitle),
          actions: [
            IconButton(
                tooltip: AppString.kDeleteAllBookmarksTitle,
                // Use a lambda () => to delay execution until button pressed
                onPressed: () async => await _handleDeleteAllBookmarks(context),
                // why need to use  ()=>
                icon: const Icon(Icons.delete_forever))
          ],
        ),
        body: Consumer<BookmarksProvider>(
          // Consumer listens for changes in BookmarksProvider and rebuilds
          builder: (context, bookmarksProvider, child) {
            final List<NewsModel> bookmarks = bookmarksProvider.bookmarkedNews;

// Show friendly UI when no bookmarks found
            if (bookmarks.isEmpty) {
              return const NoResultsWidget(
                title: AppString.kNoBookmarksFound,
              );
            }
            // List all bookmarked news articles
            return ListView.builder(
              itemCount: bookmarks.length,
              itemBuilder: (context, index) {
                return ChangeNotifierProvider.value(
                    value: bookmarks[index], child: const ArticleItemWidget());
              },
            );
          },
        ),
      ),
    );
  }
}




/*
static Future<void> clearAllBookmarks() async {
    try {
      final bookmarksRef = FirebaseFirestore.instance
          .collection('uses')
          .doc(AppConstant.sharedPreferences!.getString("uid"))
          .collection("news");

      final snapshot = await bookmarksRef.get();
      final batch = FirebaseFirestore.instance.batch();
      for (final doc in snapshot.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();
    } catch (e) {
      debugPrint("🔥 Error clearing Firestore bookmarks: $e");
    }
  }
}
  Future<void> clearAllBookmarks() async {
    try {
      DatabaseService.clearAllBookmarks();
      _bookmarkedNews.clear(); // clear in-memory list
      notifyListeners();
    } catch (e) {
      debugPrint("🔥 Error clearing Firestore bookmarks: $e");
    }
  }
class _BookmarksPageState extends State<BookmarksPage> {
  /// Handles deletion confirmation and bookmark clearing
  Future<void> _handleDeleteAllBookmarks(BuildContext context) async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => ConfirmationDialog(
        dialogIcon: Icons.delete,
        dialogTitle: AppString.kDeleteAllBookmarksTitle,
        message: AppString.kDeleteAllBookmarksMessage,
        onCancel: () => Navigator.pop(context, false),
        onConfirm: () => Navigator.pop(context, true),
      ),
    );

    if (confirmed == true) {
      final bookmarksProvider =
          Provider.of<BookmarksProvider>(context, listen: false);
      print("Bangladesh");
      await bookmarksProvider.clearAllBookmarks();
      setState(() {}); // Trigger UI update
    }
  }
why without remove after delete all but need to refrash 
*/