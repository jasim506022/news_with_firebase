import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../res/app_colors.dart';

class ErrorNullWidget extends StatelessWidget {
  const ErrorNullWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          height: 150,
          "asset/app_image/empty_image.png",
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "No News Avaiable",
          style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: AppColors.deepred),
        )
      ],
    );
  }
}
