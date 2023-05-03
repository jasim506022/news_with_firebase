import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapps/service/splashservice.dart';

import '../../const/globalcolors.dart';



class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  SplashService splashService = SplashService();
  @override
  void initState() {
    splashService.isMainPage(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: GlobalColors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("JU",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: GlobalColors.red,
                          fontSize: 40,
                          fontWeight: FontWeight.w900))),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                    color: GlobalColors.red,
                    borderRadius: BorderRadius.circular(10)),
                child: Text("News",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: GlobalColors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w900))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
