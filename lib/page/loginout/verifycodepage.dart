import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newsapps/const/function.dart';
import 'package:newsapps/page/news/homepage.dart';

import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import '../../const/globalcolors.dart';
import '../../service/othersprovider.dart';
import '../../widget/roundbutton.dart';


class VerifiyCodePage extends StatefulWidget {
  const VerifiyCodePage({super.key, required this.verificationId});

  final String verificationId;

  @override
  State<VerifiyCodePage> createState() => _VerifiyCodePageState();
}

class _VerifiyCodePageState extends State<VerifiyCodePage> {
  String pinNumber = "";

  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
     final newsmodelProvider = Provider.of<IsBookmarkProvider>(context);
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
          color: GlobalColors.black,
          fontSize: 20,
          letterSpacing: 1,
          fontWeight: FontWeight.w700),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(93, 92, 92, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: GlobalColors.deepred, width: 2),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      textStyle: TextStyle(
          color: GlobalColors.white,
          fontSize: 20,
          letterSpacing: 1,
          fontWeight: FontWeight.w700),
      decoration: defaultPinTheme.decoration?.copyWith(
        color: GlobalColors.deepred,
      ),
    );
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.black,
            ),
          ),
          elevation: 0,
        ),
        body: Container(
            margin: const EdgeInsets.only(left: 25, right: 25),
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'asset/image/otp.png',
                    width: 150,
                    height: 150,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Text(
                    "Phone Verification",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "We need to register your phone without getting started!",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Pinput(
                    length: 6,
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: focusedPinTheme,
                    submittedPinTheme: submittedPinTheme,
                    showCursor: true,
                    onCompleted: (pin) {
                      pinNumber = pin;
                      setState(() {});
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  RoundButton(
                      text: "Verify Phone Number",
                      loading: newsmodelProvider.isLoading,
                      onTap: () async {
                       newsmodelProvider.setLoading(isLoading: true);
                        final cendial = PhoneAuthProvider.credential(
                            verificationId: widget.verificationId,
                            smsCode: pinNumber);
                        try {
                          await auth.signInWithCredential(cendial);
                          Navigator.pushNamed(context, HomePage.routeName);
                          GlobalMethod.toastMessage("Login Successfully");
                          newsmodelProvider.setLoading(isLoading: false);
                        } catch (e) {
                          GlobalMethod.toastMessage(e.toString());
                         newsmodelProvider.setLoading(isLoading: false);
                        }
                      })
                ],
              ),
            )));
  }
}
