import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapps/service/provider/loadingprovider.dart';

import '../const/globalcolors.dart';

class SignWithIcon extends StatelessWidget {
  const SignWithIcon({
    super.key,
    required this.loading,
    required this.text,
    required this.onTap,
    required this.image,
  });

  final LoadingProvider loading;
  final String text;
  final VoidCallback onTap;
  final String image;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: GlobalColors.deepred, width: 2),
            borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: loading.isLoadinggmail
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image(
                      height: 35,
                      width: 35,
                      image: AssetImage(
                        image,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      text,
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: GlobalColors.black,
                              fontSize: 14,
                              letterSpacing: 1,
                              fontWeight: FontWeight.w800)),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
