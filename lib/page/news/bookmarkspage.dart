import 'package:flutter/material.dart';
import 'package:newsapps/model/bookmarksmodel.dart';
import 'package:newsapps/widget/articlewidget.dart';
import 'package:provider/provider.dart';
import '../../const/fontstyle.dart';
import '../../const/function.dart';
import '../../service/bookmarksprovider.dart';
import '../../service/database_service.dart';
import '../../widget/drawerwidget.dart';
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
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text('Bookmarks', style: appBarTextStyle),
        ),
        drawer: const DrawerWidget(),
        body: FutureBuilder<List<BookmarksModel>>(
          future: newsProvider.fetchAllNews(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingArticleWidget();
            } else if (snapshot.hasError) {
              return GlobalMethod.errorMethod(error: snapshot.error.toString());
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
