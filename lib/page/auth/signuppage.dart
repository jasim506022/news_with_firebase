import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapps/res/const.dart';
import 'package:newsapps/res/app_colors.dart';
import 'package:newsapps/page/auth/loginpage.dart';
import 'package:newsapps/service/provider/loadingprovider.dart';
import 'package:provider/provider.dart';

import '../../widget/newstextfieldwidget.dart';
import '../../widget/roundbutton.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _form = GlobalKey<FormState>();

  FocusNode emailNode = FocusNode();
  FocusNode passwordNode = FocusNode();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailNode.dispose();
    passwordNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: const Color(0xffE5E5E5),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Sign up",
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: AppColors.black,
                                fontSize: 20,
                                letterSpacing: 1,
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Icon(
                          Icons.person_2,
                          size: 30,
                        )
                      ],
                    ),
                    Text(
                      "Welcome to Jasim Uddin News",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: AppColors.lightCardColor,
                            fontSize: 14,
                            letterSpacing: 1,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Image(
                      image: AssetImage(
                        "asset/image/newj.png",
                      ),
                      height: 200,
                      width: double.infinity,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Form(
                        key: _form,
                        child: Column(
                          children: [
                            NewsTextFieldWidget(
                              emailController: emailController,
                              hintText: 'Email',
                              icon: Icons.email,
                              keyboardType: TextInputType.emailAddress,
                              obscureText: false,
                              validatorText: 'Enter Your Email Address',
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            NewsTextFieldWidget(
                              emailController: passwordController,
                              hintText: 'Password',
                              icon: Icons.lock,
                              keyboardType: TextInputType.text,
                              obscureText: true,
                              validatorText: 'Enter Your Password Address',
                            ),
                          ],
                        )),
                    const SizedBox(
                      height: 15,
                    ),
                    Consumer<LoadingProvider>(
                      builder: (context, loadingProvider, child) {
                        return RoundButton(
                          text: 'Sign Up',
                          loading: loadingProvider,
                          onTap: () {
                            if (_form.currentState!.validate()) {
                              Provider.of<LoadingProvider>(context,
                                      listen: false)
                                  .setUploading(loading: true);

                              FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                      email: emailController.text.toString(),
                                      password:
                                          passwordController.text.toString())
                                  .then((value) {
                                Provider.of<LoadingProvider>(context,
                                        listen: false)
                                    .setUploading(loading: false);
                                Navigator.pushNamed(
                                    context, LoginPage.routeName);
                              }).onError((error, stackTrace) {
                                globalMethod.toastMessage(error.toString());
                                Provider.of<LoadingProvider>(context,
                                        listen: false)
                                    .setUploading(loading: false);
                              });
                            }
                          },
                        );
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already Have a Account",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: AppColors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600)),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, LoginPage.routeName);
                            },
                            child: Text("Login",
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        color: AppColors.deepred,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w800))))
                      ],
                    ),
                    const SizedBox(
                      height: 200,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
