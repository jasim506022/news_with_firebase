import 'package:flutter/material.dart';

class OnboardModel {
  final String image;
  final String title;
  final String description;
  final Color backgroundColor;
  final Color buttonBackgroundColor;

  OnboardModel({
    required this.image,
    required this.title,
    required this.description,
    required this.backgroundColor,
    required this.buttonBackgroundColor,
  });
}
