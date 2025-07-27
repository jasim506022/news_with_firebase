import 'package:flutter/material.dart';
import 'package:newsapps/model/news_model_.dart';
import 'package:newsapps/widget/article_item_widget.dart';
import 'package:provider/provider.dart';
import '../../service/provider/bookmarksprovider.dart';
import '../../loading/loading_articles_list_widget.dart';

class BookmarskPage extends StatefulWidget {
  const BookmarskPage({super.key});

  @override
  State<BookmarskPage> createState() => _BookmarskPageState();
}

class _BookmarskPageState extends State<BookmarskPage> {
  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<BookmarksProvider>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Bookmarks'),
          actions: [
            IconButton(
                tooltip: 'Delete All Bookmarks',
                onPressed: () async {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Confirm"),
                      content: const Text(
                          "Are you sure you want to delete all bookmarks?"),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: const Text("Delete"),
                        ),
                      ],
                    ),
                  );

                  if (confirm == true) {
                    await newsProvider
                        .clearAllBookmarks(); // Call the provider method
                    setState(() {}); // Refresh UI
                  }
                },
                icon: const Icon(Icons.delete_forever))
          ],
        ),
        body: FutureBuilder<List<NewsModel>>(
          future: newsProvider.fetchAllNews(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingArticleWidget();
            } else if (snapshot.hasError) {
              // return globalMethod.errorMethod(error: snapshot.error.toString());
            } else if (!snapshot.hasData) {
              return Image.asset("asset/image/nonewsitemfound.png");
            }
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ChangeNotifierProvider.value(
                    value: snapshot.data![index],
                    child: const ArticleItemWidget(
                      isBookmarks: true,
                      isDelete: true,
                    ));
              },
            );
          },
        ),
      ),
    );
  }
}
