import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'globalcolors.dart';

class TextFontStyle {
  static TextStyle titleTextSTyle(BuildContext context) {
    return GoogleFonts.poppins(
        textStyle: TextStyle(
            color: Theme.of(context).iconTheme.color,
            fontSize: 14,
            letterSpacing: 1,
            fontWeight: FontWeight.w800));
  }

  static TextStyle titleTextstyleblack(BuildContext context) {
    return GoogleFonts.poppins(
        textStyle: TextStyle(
            color: Theme.of(context).iconTheme.color,
            fontSize: 15,
            fontWeight: FontWeight.w500));
  }
}

TextStyle tabunselectedLabelStyle = GoogleFonts.poppins(
    textStyle: TextStyle(
        color: GlobalColors.white, fontSize: 15, fontWeight: FontWeight.w600));

TextStyle newstextStyle = GoogleFonts.poppins(
    textStyle: TextStyle(
        color: GlobalColors.lightCardColor,
        fontSize: 13,
        fontWeight: FontWeight.w600));

TextStyle tabLabelStyle = GoogleFonts.poppins(
    textStyle: TextStyle(
        color: GlobalColors.white, fontSize: 15, fontWeight: FontWeight.w800));

TextStyle appBarTextStyle = GoogleFonts.poppins(
    textStyle: TextStyle(
        color: GlobalColors.black,
        fontSize: 16,
        letterSpacing: 1,
        fontWeight: FontWeight.w800));
