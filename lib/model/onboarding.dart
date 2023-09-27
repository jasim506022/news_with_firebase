import 'package:flutter/material.dart';

class OnboardModel {
  String img;
  String text;
  String desc;
  Color bg;
  Color button;

  OnboardModel({
    required this.img,
    required this.text,
    required this.desc,
    required this.bg,
    required this.button,
  });
}

List<OnboardModel> onboardModeList = [
  OnboardModel(
      img: "asset/image/onboard/pageone.png",
      text: "Diverse News Sources",
      desc:
          "Discover a wide range of news sources, from reputable publications to local sources, all in one place.",
      bg: Colors.white,
      button: Colors.black),
  OnboardModel(
      img: "asset/image/onboard/pagetwo.png",
      text: "Bookmark and Save",
      desc:
          "Easily bookmark articles and save them for later. Never lose track of an important story.",
      bg: Colors.black,
      button: Colors.white),
  OnboardModel(
      img: "asset/image/onboard/pagethree.png",
      text: "Breaking News Alerts",
      desc:
          "Stay ahead of the curve with real-time notifications for breaking stories.",
      bg: Colors.black,
      button: Colors.black)
];
