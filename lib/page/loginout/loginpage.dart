import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapps/const/globalcolors.dart';
import 'package:newsapps/page/loginout/signuppage.dart';
import 'package:newsapps/page/news/homepage.dart';
import 'package:provider/provider.dart';
import '../../const/function.dart';
import '../../service/othersprovider.dart';
import '../../widget/newstextfieldwidget.dart';
import '../../widget/roundbutton.dart';
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
  FocusNode emailNode = FocusNode();
  FocusNode passwordNode = FocusNode();
  final _form = GlobalKey<FormState>();

  FirebaseAuth auth = FirebaseAuth.instance;
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
    final newsmodelProvider = Provider.of<IsBookmarkProvider>(context);
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
                            color: GlobalColors.gray,
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
                              focusnode: emailNode,
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
                              focusnode: passwordNode,
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
                    RoundButton(
                      text: 'Login',
                      loading: newsmodelProvider.isLoading,
                      onTap: () {
                        if (_form.currentState!.validate()) {
                          newsmodelProvider.setLoading(isLoading: true);

                          auth
                              .signInWithEmailAndPassword(
                                  email: emailController.text.toString(),
                                  password: passwordController.text.toString())
                              .then((value) {
                            newsmodelProvider.setLoading(isLoading: false);
                            Navigator.pushNamed(context, HomePage.routeName);
                            GlobalMethod.toastMessage("Login Successfully");
                          }).onError((error, stackTrace) {
                            GlobalMethod.toastMessage(error.toString());
                            setState(() {
                              newsmodelProvider.setLoading(isLoading: false);
                            });
                          });
                        }
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SignWithIcon(
                      loading: false,
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
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SignWithIcon(
                      loading: newsmodelProvider.isLoadingGmail,
                      image: "asset/image/gmail.png",
                      text: 'Login With Gmail',
                      onTap: () {
                        newsmodelProvider.setLoadingGmail(isLoading: true);
                        GlobalMethod.googleSignUp();
                        GlobalMethod.toastMessage("Login Successfully");
                        newsmodelProvider.setLoadingphone(isLoading: false);
                        Navigator.pushNamed(context, HomePage.routeName);
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

class SignWithIcon extends StatelessWidget {
  const SignWithIcon({
    super.key,
    required this.loading,
    required this.text,
    required this.onTap,
    required this.image,
  });

  final bool loading;
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
          child: loading
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
