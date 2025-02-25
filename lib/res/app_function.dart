import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:newsapps/service/provider/themeprovider.dart';

import 'app_text_style.dart';
import 'app_colors.dart';

class AppFunction {
  final auth = FirebaseAuth.instance;

  Column errorMethod({required String error}) {
    return Column(
      children: [
        Flexible(
          flex: 7,
          child: Image.asset(
            "asset/image/nonewsitemfound.png",
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Flexible(
          flex: 3,
          child: Text(
            error,
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    color: AppColors.red,
                    fontSize: 16,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w800)),
          ),
        ),
      ],
    );
  }

  Container applogo() {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: AppColors.white,
          border: Border.all(color: AppColors.red, width: 1)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("JU",
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      color: AppColors.red,
                      fontSize: 14,
                      fontWeight: FontWeight.w900))),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
                color: AppColors.red, borderRadius: BorderRadius.circular(1)),
            child: Text("News",
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: AppColors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w600))),
          )
        ],
      ),
    );
  }

  ThemeData themeDate(ThemeProvider themeProvider) {
    return ThemeData(
        appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(
                color: themeProvider.getDarkTheme
                    ? AppColors.white
                    : AppColors.black),
            backgroundColor: themeProvider.getDarkTheme
                ? AppColors.darkCardColor
                : AppColors.white,
            elevation: 0.0,
            centerTitle: true,
            titleTextStyle: GoogleFonts.poppins(
                textStyle: TextStyle(
                    color: themeProvider.getDarkTheme
                        ? Colors.white
                        : AppColors.deepred,
                    fontSize: 18,
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold)),
            systemOverlayStyle: SystemUiOverlayStyle(
                systemNavigationBarColor: themeProvider.getDarkTheme
                    ? AppColors.darkCardColor
                    : AppColors.white,
                systemNavigationBarIconBrightness: themeProvider.getDarkTheme
                    ? Brightness.light
                    : Brightness.dark,
                statusBarIconBrightness: themeProvider.getDarkTheme
                    ? Brightness.light
                    : Brightness.dark,
                statusBarColor: themeProvider.getDarkTheme
                    ? AppColors.darkBackgroundColor
                    : Colors.white)),
        scaffoldBackgroundColor: themeProvider.getDarkTheme
            ? AppColors.darkBackgroundColor
            : AppColors.white,
        iconTheme: IconThemeData(
            color: themeProvider.getDarkTheme ? Colors.white : Colors.black),
        cardColor: themeProvider.getDarkTheme
            ? AppColors.darkCardColor
            : AppColors.white,
        primaryColor: themeProvider.getDarkTheme ? Colors.white : Colors.black);
  }

  toastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        gravity: ToastGravity.BOTTOM,
        fontSize: 16.0,
        backgroundColor: AppColors.red,
        textColor: Colors.white);
  }

  String formattedDatText(String publishArt) {
    DateTime pareseData = DateTime.parse(publishArt);
    String formattedDate = DateFormat("yyyy-MM-dd hh:mm:ss").format(pareseData);
    DateTime publishDate =
        DateFormat("yyyy-MM-dd hh:mm:ss").parse(formattedDate);
    return "${publishDate.day}/${publishDate.month}/${publishDate.year} on ${publishDate.hour}:${publishDate.minute}";
  }

  ElevatedButton paginationButton(
      {required Function function, required String text}) {
    return ElevatedButton(
        onPressed: () {
          function();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.deepred,
        ),
        child: Text(
          text,
          style: GoogleFonts.poppins(textStyle: tabLabelStyle),
        ));
  }

  Future<void> errorDialog(
      {required String errorMessage, required BuildContext context}) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(errorMessage),
          title: const Row(
            children: [
              Icon(
                IconlyBold.danger,
                color: Colors.red,
              ),
              SizedBox(
                width: 8,
              ),
              Text('An error occured'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              },
              child: const Text('Ok'),
            ),
          ],
        );
      },
    );
  }
}
