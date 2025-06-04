import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../model/category_model.dart';
import '../../res/app_colors.dart';
import '../../res/app_function.dart';
import '../../res/app_text_style.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
    required this.categoryModel,
  });

  final CategoryModel categoryModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: categoryModel.color, borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          Stack(
            children: [
              Column(
                children: [
                  Text(categoryModel.name,
                      style: AppTextStyle.titleTextSTyle(context)
                          .copyWith(color: AppColors.white)),
                  AppFunction.verticalSpace(10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: Image(
                      image: AssetImage(categoryModel.image),
                      height: 110.h,
                      width: 200.w,
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  height: 30.h,
                  width: 30.h,
                  padding: EdgeInsets.all(5.r),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: AppColors.white),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.black,
                    size: 20.h,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
