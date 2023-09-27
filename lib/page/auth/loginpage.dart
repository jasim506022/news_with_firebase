import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapps/const/const.dart';
import 'package:newsapps/const/globalcolors.dart';
import 'package:newsapps/page/auth/signuppage.dart';
import 'package:newsapps/page/news/homepage.dart';
import 'package:newsapps/service/provider/loadingprovider.dart';
import 'package:provider/provider.dart';
import '../../service/other/apiservice.dart';
import '../../widget/newstextfieldwidget.dart';
import '../../widget/roundbutton.dart';
import '../../widget/signwithiconwidget.dart';
import 'loginwithphonenumber.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static const routeName = "/LoginDetailsPage";
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _form = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Color(0xffE5E5E5),
        statusBarIconBrightness: Brightness.dark));

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: WillPopScope(
        onWillPop: () async {
          SystemNavigator.pop();
          return true;
        },
        child: SafeArea(
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
                          "Login",
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: GlobalColors.black,
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
                            color: GlobalColors.lightCardColor,
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
                          text: 'Login',
                          loading: loadingProvider,
                          onTap: () {
                            if (_form.currentState!.validate()) {
                              Provider.of<LoadingProvider>(context,
                                      listen: false)
                                  .setUploading(loading: true);
                              FirebaseAuth auth = FirebaseAuth.instance;
                              auth
                                  .signInWithEmailAndPassword(
                                      email: emailController.text.toString(),
                                      password:
                                          passwordController.text.toString())
                                  .then((value) {
                                sharedPreferences!
                                    .setString("uid", value.user!.uid);
                                Provider.of<LoadingProvider>(context,
                                        listen: false)
                                    .setUploading(loading: false);
                                Navigator.pushNamed(
                                    context, HomePage.routeName);
                                globalMethod.toastMessage("Login Successfully");
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
                    Consumer<LoadingProvider>(
                      builder: (context, loadingProvider, child) {
                        return SignWithIcon(
                          loading: loadingProvider,
                          image: "asset/image/phone.png",
                          text: 'Login With Phone Number',
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const LoginWithPhoneNukmberPage(),
                                ));
                          },
                        );
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Consumer<LoadingProvider>(
                      builder: (context, loadingProvider, child) {
                        return SignWithIcon(
                          loading: loadingProvider,
                          image: "asset/image/gmail.png",
                          text: 'Login With Gmail',
                          onTap: () {
                            Provider.of<LoadingProvider>(context, listen: false)
                                .setLoadingGmail(loading: true);
                            ApiServices.googleSignUp();
                            globalMethod.toastMessage("Login Successfully");
                            Provider.of<LoadingProvider>(context, listen: false)
                                .setLoadingGmail(loading: false);
                            Navigator.pushNamed(context, HomePage.routeName);
                          },
                        );
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't Have an Account",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: GlobalColors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600)),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignUpPage(),
                                  ));
                            },
                            child: Text("Sign Up",
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        color: GlobalColors.deepred,
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
