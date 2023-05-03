import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapps/const/function.dart';
import 'package:newsapps/page/loginout/verifycodepage.dart';
import 'package:newsapps/widget/roundbutton.dart';
import 'package:provider/provider.dart';
import '../../const/globalcolors.dart';
import '../../service/othersprovider.dart';

class LoginWithPhoneNukmberPage extends StatefulWidget {
  const LoginWithPhoneNukmberPage({super.key});

  @override
  State<LoginWithPhoneNukmberPage> createState() =>
      _LoginWithPhoneNukmberPageState();
}

class _LoginWithPhoneNukmberPageState extends State<LoginWithPhoneNukmberPage> {
  final phoneNumberController = TextEditingController();
  String countryCode = "+880";
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final newsmodelProvider = Provider.of<IsBookmarkProvider>(context);
    return GestureDetector(
      onTap: () {
         FocusScope.of(context).unfocus();
      },
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Image.asset(
                    'asset/image/phonenumber.png',
                    width: double.infinity,
                    height: 160,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Text(
                    "Phone Verification",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: GlobalColors.red,
                            fontSize: 22,
                            letterSpacing: 1,
                            fontWeight: FontWeight.w800)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "We need to register your phone without getting started!",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: GlobalColors.black,
                            fontSize: 16,
                            letterSpacing: 1,
                            fontWeight: FontWeight.normal)),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 55,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: 60,
                          child: Text(
                            countryCode,
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: GlobalColors.black,
                                    fontSize: 17,
                                    letterSpacing: 1,
                                    fontWeight: FontWeight.w500)),
                          ),
                        ),
                        const Text(
                          "|",
                          style: TextStyle(fontSize: 33, color: Colors.grey),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextFormField(
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: GlobalColors.black,
                                    fontSize: 17,
                                    letterSpacing: 1,
                                    fontWeight: FontWeight.w500)),
                            keyboardType: TextInputType.number,
                            controller: phoneNumberController,
                            decoration: const InputDecoration(
                                hintText: 'PhoneNumber',
                                border: InputBorder.none),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  RoundButton(
                      text: "Send the code",
                      loading: newsmodelProvider.isLoadingphone,
                      onTap: () {
                        newsmodelProvider.setLoadingphone(isLoading: true);
                        auth.verifyPhoneNumber(
                          verificationCompleted: (phoneAuthCredential) {},
                          phoneNumber: countryCode + phoneNumberController.text,
                          verificationFailed: (error) {
                            GlobalMethod.toastMessage(error.toString());
                          },
                          codeSent: (verificationId, forceResendingToken) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => VerifiyCodePage(
                                      verificationId: verificationId),
                                ));
                            newsmodelProvider.setLoadingphone(isLoading: true);
                          },
                          codeAutoRetrievalTimeout: (verificationId) {
                            GlobalMethod.toastMessage(verificationId);
                            newsmodelProvider.setLoading(isLoading: true);
                          },
                        );
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
