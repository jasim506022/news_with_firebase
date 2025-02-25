import 'package:flutter/material.dart';
import 'package:newsapps/res/const.dart';
import 'package:newsapps/model/bookmarksmodel.dart';
import 'package:newsapps/widget/articlewidget.dart';
import 'package:provider/provider.dart';
import '../../service/provider/bookmarksprovider.dart';
import '../../widget/loadingarticlewidget.dart';

class BookmarskPage extends StatefulWidget {
  static const routeName = "/BookmarksPage";
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
        ),
        body: FutureBuilder<List<BookmarksModel>>(
          future: newsProvider.fetchAllNews(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingArticleWidget();
            } else if (snapshot.hasError) {
              return globalMethod.errorMethod(error: snapshot.error.toString());
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
