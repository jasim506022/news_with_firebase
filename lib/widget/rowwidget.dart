import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapps/const/fontstyle.dart';

class RowWidget extends StatelessWidget {
  const RowWidget({
    super.key,
    required this.title,
    required this.function,
  });

  final String title;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Top News", style: TextFontStyle.titleTextSTyle(context)),
        InkWell(
          onTap: () {
            function();
          },
          child: Text("See All",
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      color: Theme.of(context).iconTheme.color,
                      fontSize: 14,
                      letterSpacing: 1,
                      fontStyle: FontStyle.normal))),
        ),
      ],
    );
  }
}
