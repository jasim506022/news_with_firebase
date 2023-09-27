import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapps/const/const.dart';

import '../../model/onboarding.dart';
import 'loginpage.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int currentindex = 0;

  PageController pageController = PageController(initialPage: 0);

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  newOnBoardInfo() async {
    int isViewd = 0;
    await sharedPreferences!.setInt("onBoard", isViewd);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: currentindex % 2 == 0
            ? Colors.white
            : const Color.fromARGB(255, 190, 78, 255),
        appBar: AppBar(
          backgroundColor: currentindex % 2 == 0
              ? Colors.white
              : const Color.fromARGB(255, 190, 78, 255),
          automaticallyImplyLeading: false,
          actions: [
            TextButton(
                onPressed: () {
                  newOnBoardInfo();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ));
                },
                child: Text("Skip",
                    style: GoogleFonts.inter(
                        fontSize: 16,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                        color: currentindex % 2 == 0
                            ? Theme.of(context).primaryColor
                            : Colors.white)))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: PageView.builder(
            controller: pageController,
            itemCount: onboardModeList.length,
            onPageChanged: (value) {
              setState(() {
                currentindex = value;
              });
            },
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    onboardModeList[index].img,
                    height: 350,
                    fit: BoxFit.fill,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 10.0,
                    child: ListView.builder(
                      itemCount: onboardModeList.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 8,
                              width: 8,
                              margin: const EdgeInsets.symmetric(horizontal: 3),
                              decoration: BoxDecoration(
                                  color: currentindex == index
                                      ? Colors.red
                                      : Colors.brown,
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Text(
                    onboardModeList[index].text,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: currentindex % 2 == 0
                            ? Theme.of(context).primaryColor
                            : Colors.white),
                  ),
                  Text(onboardModeList[index].desc,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                          fontSize: 16,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                          color: currentindex % 2 == 0
                              ? Theme.of(context).primaryColor
                              : Colors.white)),
                  InkWell(
                    onTap: () async {
                      if (index == onboardModeList.length - 1) {
                        await newOnBoardInfo();
                        // ignore: use_build_context_synchronously
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ));
                      }
                      pageController.nextPage(
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.bounceIn);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                      decoration: BoxDecoration(
                          color: currentindex % 2 == 0
                              ? Theme.of(context).primaryColor
                              : Colors.black,
                          borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Next",
                            style: GoogleFonts.inter(
                                fontSize: 20,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          const Icon(
                            Icons.arrow_forward_sharp,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              );
            },
          ),
        ));
  }
}
