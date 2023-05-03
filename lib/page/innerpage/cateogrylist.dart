import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapps/page/news/alltopnews.dart';
import 'package:newsapps/page/innerpage/categroypage.dart';
import '../../const/function.dart';
import '../../const/globalcolors.dart';
import '../../model/categorymodel.dart';
import '../../widget/drawerwidget.dart';

class CategoryList extends StatefulWidget {
    static const routeName = "/CategoryList";
  const CategoryList({super.key});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: GlobalColors.black),
        backgroundColor: GlobalColors.white,
        elevation: 1,
        centerTitle: true,
        title: GlobalMethod.applogo(),
      ),
      drawer: const DrawerWidget(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: GridView.builder(
          itemCount: listcategory.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              crossAxisCount: 2,
              childAspectRatio: .9),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                listcategory[index].name == "All News"
                    ? Navigator.pushNamed(context, AllTopNews.routeName)
                    : Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategoryPage(
                            categoryname: listcategory[index].name,
                          ),
                        ));
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: listcategory[index].color,
                    borderRadius: BorderRadius.circular(8)),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Column(
                          children: [
                            Text(
                              listcategory[index].name,
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: GlobalColors.white,
                                      fontSize: 18,
                                      letterSpacing: 1,
                                      fontWeight: FontWeight.w800)),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image(
                                image: AssetImage(
                                  listcategory[index].image,
                                ),
                                height: 120,
                                width: 200,
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                            child: const Icon(Icons.arrow_forward_ios,
                                color: Colors.black),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
