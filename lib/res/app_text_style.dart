import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyle {
  static TextStyle get logoTitleTextStyle => GoogleFonts.pacifico(
      textStyle: TextStyle(
          color: AppColors.red, fontSize: 35.sp, fontWeight: FontWeight.w900));

  static TextStyle get logoSubTitleStyle => GoogleFonts.poppins(
      textStyle: TextStyle(
          color: AppColors.white,
          fontSize: 17.sp,
          fontWeight: FontWeight.w900));

// title
  static TextStyle get titleLargeTextStyle => GoogleFonts.poppins(
      textStyle: TextStyle(
          color: AppColors.white,
          fontSize: 25.sp,
          fontWeight: FontWeight.w800));

//
  static TextStyle mediumBoldTextStyle(BuildContext context) =>
      GoogleFonts.poppins(
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.bold,
          fontSize: 15.sp);
//
  static TextStyle mediumTextStyle(BuildContext context) => GoogleFonts.poppins(
      color: Theme.of(context).primaryColor,
      fontWeight: FontWeight.normal,
      fontSize: 15.sp);

  static TextStyle get button => GoogleFonts.poppins(
      color: AppColors.white, fontWeight: FontWeight.bold, fontSize: 15.sp);

// Using for  tite
  static TextStyle titleTextStyle(BuildContext context) {
    return GoogleFonts.poppins(
        textStyle: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 17.sp,
            letterSpacing: 1,
            fontWeight: FontWeight.w700));
  }

  static TextStyle inputText([bool isEnable = false]) => GoogleFonts.poppins(
        fontSize: 15.sp,
        color: isEnable ? AppColors.black : AppColors.black.withOpacity(.8),
        fontWeight: isEnable ? FontWeight.w600 : FontWeight.w800,
      );

  // Input Fields & Hints
  static TextStyle get hintText => GoogleFonts.poppins(
        fontSize: 15.sp,
        color: AppColors.grey,
        fontWeight: FontWeight.normal,
      );

  static TextStyle titleTextstyleblack(BuildContext context) {
    return GoogleFonts.poppins(
        textStyle: TextStyle(
            color: Theme.of(context).iconTheme.color,
            fontSize: 15,
            fontWeight: FontWeight.w500));
  }

  static TextStyle label(BuildContext context) => GoogleFonts.poppins(
        color: Theme.of(context).primaryColor,
        fontSize: 15.sp,
        fontWeight: FontWeight.w700,
      );
  static TextStyle get authTitle => GoogleFonts.poppins(
      color: AppColors.red,
      fontSize: 28.sp,
      letterSpacing: 1.2,
      fontWeight: FontWeight.w800);

  static TextStyle get authDescription => GoogleFonts.poppins(
      color: AppColors.black,
      fontSize: 20.sp,
      letterSpacing: 1.1,
      fontWeight: FontWeight.normal);

  static TextStyle get errorValue => GoogleFonts.poppins(
      fontSize: 20.sp, fontWeight: FontWeight.w900, color: AppColors.deepred);

  static TextStyle newstextStyle = GoogleFonts.poppins(
      textStyle: TextStyle(
          color: AppColors.lightCardColor,
          fontSize: 13.sp,
          fontWeight: FontWeight.w600));

  static TextStyle get pinNumberTextStyle => GoogleFonts.poppins(
      color: AppColors.black,
      fontSize: 22.sp,
      letterSpacing: 1,
      fontWeight: FontWeight.w700);

  //
  static TextStyle get authTextStyle => GoogleFonts.poppins(
        textStyle: TextStyle(
          color: AppColors.lightCardColor,
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        ),
      );
  //
  static TextStyle get sourceTextStyle => GoogleFonts.poppins(
        textStyle: TextStyle(
          color: AppColors.deepred,
          fontSize: 15.sp,
          fontWeight: FontWeight.w700,
        ),
      );

  //
  static TextStyle appBarTextStyle = GoogleFonts.poppins(
      textStyle: TextStyle(
          color: AppColors.black,
          fontSize: 16.sp,
          letterSpacing: 1,
          fontWeight: FontWeight.w700));

  static TextStyle noResultsTextStyle = GoogleFonts.bebasNeue(
      fontSize: 30.sp,
      fontWeight: FontWeight.w800,
      color: AppColors.red,
      letterSpacing: 1.2);
}

TextStyle tabunselectedLabelStyle = GoogleFonts.poppins(
    textStyle: TextStyle(
        color: AppColors.white, fontSize: 15.sp, fontWeight: FontWeight.w600));

TextStyle tabLabelStyle = GoogleFonts.poppins(
    textStyle: TextStyle(
        color: AppColors.white, fontSize: 15.sp, fontWeight: FontWeight.w800));
