import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapps/const/globalcolors.dart';

class RoundButton extends StatelessWidget {
  const RoundButton(
      {super.key,
      required this.text,
      required this.onTap,
      this.loading = false});
  final String text;
  final VoidCallback onTap;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            color: GlobalColors.deepred,
            borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: loading
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : Text(
                  text,
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: GlobalColors.white,
                          fontSize: 14,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w800)),
                ),
        ),
      ),
    );
  }
}
