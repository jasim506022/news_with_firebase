import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:newsapps/service/provider/themeprovider.dart';

import 'app_text_style.dart';
import 'app_colors.dart';

class AppFunction {
  final auth = FirebaseAuth.instance;

  static SizedBox verticalSpace(double height) {
    return SizedBox(height: height.h);
  }

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
      ],
    );
  }

  ThemeData themeDate(ThemeProvider themeProvider) {
    var isDark = themeProvider.getDarkTheme;
    return ThemeData(
        dialogTheme: DialogTheme(
          backgroundColor: isDark ? AppColors.cardDark : AppColors.white,
          titleTextStyle: GoogleFonts.poppins(
            color: isDark ? AppColors.white : AppColors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
          contentTextStyle: GoogleFonts.poppins(
            color: isDark
                ? AppColors.white.withOpacity(.7)
                : AppColors.black.withOpacity(.7),
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        tabBarTheme: TabBarTheme(
          labelStyle: tabLabelStyle,
          tabAlignment: TabAlignment.start,
          dividerColor: Colors.transparent,
          indicatorColor: Colors.transparent,
          indicatorSize: TabBarIndicatorSize.tab,
          unselectedLabelStyle: tabunselectedLabelStyle,
          labelColor: Colors.white,
          unselectedLabelColor: isDark ? AppColors.white : AppColors.black,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(5.r),
            color: AppColors.red,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              backgroundColor: AppColors.red,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.r))),
        ),
        progressIndicatorTheme: ProgressIndicatorThemeData(
          color: AppColors.white,
          linearTrackColor: Colors.green,
          circularTrackColor: Colors.green,
          refreshBackgroundColor: Colors.green,
        ),
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
                        : AppColors.red,
                    fontSize: 20.sp,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w900)),
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
            color: themeProvider.getDarkTheme ? Colors.white : Colors.black,
            size: 25.h),
        cardColor: themeProvider.getDarkTheme
            ? AppColors.darkCardColor
            : AppColors.white,
        primaryColor: themeProvider.getDarkTheme ? Colors.white : Colors.black);
  }

  static toastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        gravity: ToastGravity.BOTTOM,
        fontSize: 16.0.sh,
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
