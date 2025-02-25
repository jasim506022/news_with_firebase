import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapps/res/const.dart';
import 'package:newsapps/page/news/alltopnews.dart';
import 'package:newsapps/page/innerpage/categroypage.dart';
import 'package:newsapps/page/news/homepage.dart';
import '../../res/app_colors.dart';
import '../../model/categorymodel.dart';

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
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ));
            },
            icon: const Icon(Icons.arrow_back)),
        title: globalMethod.applogo(),
      ),
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
                                      color: AppColors.white,
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
