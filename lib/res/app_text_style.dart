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

  static TextStyle get titleLargeTextStyle => GoogleFonts.poppins(
      textStyle: TextStyle(
          color: AppColors.white,
          fontSize: 25.sp,
          fontWeight: FontWeight.w800));

  static TextStyle mediumBoldTextStyle(BuildContext context) =>
      GoogleFonts.poppins(
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.bold,
          fontSize: 15.sp);

  static TextStyle get button => GoogleFonts.poppins(
      color: AppColors.white, fontWeight: FontWeight.bold, fontSize: 15.sp);

// Using for  tite
  static TextStyle titleTextSTyle(BuildContext context) {
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
        color: AppColors.gray,
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
  static TextStyle get authTitle => GoogleFonts.roboto(
      color: AppColors.black,
      fontSize: 28.sp,
      fontWeight: FontWeight.w900,
      height: 1.3,
      letterSpacing: 1.2);

  static TextStyle get authDescription => GoogleFonts.roboto(
      color: AppColors.black.withOpacity(.8),
      fontSize: 17.sp,
      fontWeight: FontWeight.normal,
      height: 1.6,
      letterSpacing: 1.2);
}

TextStyle tabunselectedLabelStyle = GoogleFonts.poppins(
    textStyle: TextStyle(
        color: AppColors.white, fontSize: 15.sp, fontWeight: FontWeight.w600));

TextStyle newstextStyle = GoogleFonts.poppins(
    textStyle: TextStyle(
        color: AppColors.lightCardColor,
        fontSize: 13.sp,
        fontWeight: FontWeight.w600));

TextStyle tabLabelStyle = GoogleFonts.poppins(
    textStyle: TextStyle(
        color: AppColors.white, fontSize: 15.sp, fontWeight: FontWeight.w800));

TextStyle appBarTextStyle = GoogleFonts.poppins(
    textStyle: TextStyle(
        color: AppColors.black,
        fontSize: 16,
        letterSpacing: 1,
        fontWeight: FontWeight.w800));
