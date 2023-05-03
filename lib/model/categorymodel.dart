import 'package:flutter/material.dart';

class CategoryModel {
  final String name;
  final String image;
  final Color color;

  CategoryModel({
    required this.name,
    required this.image,
    required this.color,
  });
}

List<CategoryModel> listcategory = [
  CategoryModel(
      name: "All News",
      image: "asset/image/category/allnews.png",
      color: const Color(0xff3E7B4F)),
  CategoryModel(
      name: "General",
      image: "asset/image/category/General.jpg",
      color: const Color(0xff43598D)),
  CategoryModel(
      name: "Technology",
      image: "asset/image/category/Technology.png",
      color: const Color(0xffF44C56)),
  CategoryModel(
      name: "Sports",
      image: "asset/image/category/Sports.png",
      color: const Color(0xff1F253B)),
  CategoryModel(
      name: "Science",
      image: "asset/image/category/Science.png",
      color: const Color(0xff0A9E84)),
  CategoryModel(
      name: "Business",
      image: "asset/image/category/Business.png",
      color: const Color(0xffF4931E)),
  CategoryModel(
      name: "Entertainment",
      image: "asset/image/category/Entertainment.png",
      color: const Color(0xff542A8A)),
  CategoryModel(
      name: "Health",
      image: "asset/image/category/Health.png",
      color: const Color(0xff55021A))
];
