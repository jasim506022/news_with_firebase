import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../model/category_model.dart';
import '../../res/app_routes.dart';
import '../../service/other/category_data.dart';
import 'category_item.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("JU News"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: GridView.builder(
          itemCount: listCategory.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              crossAxisCount: 2,
              childAspectRatio: .9),
          itemBuilder: (context, index) {
            CategoryModel categoryModel = listCategory[index];
            return InkWell(
              onTap: () {
                categoryModel.name == "All News"
                    ? Navigator.pushNamed(context, AppRoutes.allNewsPage)
                    : Navigator.pushNamed(
                        context,
                        '/categoryPage',
                        arguments: categoryModel.name,
                      );
              },
              child: CategoryItem(categoryModel: categoryModel),
            );
          },
        ),
      ),
    );
  }
}
