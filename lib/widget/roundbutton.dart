import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapps/res/app_colors.dart';
import 'package:newsapps/service/provider/loadingprovider.dart';

class RoundButton extends StatelessWidget {
  const RoundButton(
      {super.key,
      required this.text,
      required this.onTap,
      required this.loading});
  final String text;
  final VoidCallback onTap;
  final LoadingProvider loading;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            color: AppColors.deepred, borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: loading.isLoading
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : Text(
                  text,
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: AppColors.white,
                          fontSize: 14,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w800)),
                ),
        ),
      ),
    );
  }
}
