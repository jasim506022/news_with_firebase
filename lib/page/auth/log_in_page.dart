import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:newsapps/page/auth/widget/auth_intro_widget.dart';

import 'package:newsapps/res/const.dart';
import 'package:newsapps/res/app_colors.dart';
import 'package:newsapps/page/auth/sign_up_page.dart';
import 'package:newsapps/service/provider/loadingprovider.dart';
import 'package:newsapps/widget/rich_text_widget.dart';
import 'package:provider/provider.dart';
import '../../res/app_function.dart';
import '../../res/app_routes.dart';
import '../../service/other/api_service.dart';
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
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: AppColors.white,
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
            backgroundColor: AppColors.white,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const AuthIntroWidget(),
                    Form(
                        key: _form,
                        child: Column(
                          children: [
                            CustomTextFormField(
                              label: "Email",
                              controller: emailController,
                              hintText: 'Email',
                              obscureText: false,
                            ),
                            CustomTextFormField(
                              hasPasswordToggle: true,
                              label: "Password",
                              controller: passwordController,
                              hintText: 'Password',
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
                                    context, AppRoutes.homePage);
                                AppFunction.toastMessage("Login Successfully");
                              }).onError((error, stackTrace) {
                                AppFunction.toastMessage(error.toString());
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
                          image: "asset/image/gmail.png",
                          text: 'Login With Gmail',
                          onTap: () {
                            Provider.of<LoadingProvider>(context, listen: false)
                                .setLoadingGmail(loading: true);
                            ApiServices.googleSignUp();
                            AppFunction.toastMessage("Login Successfully");
                            Provider.of<LoadingProvider>(context, listen: false)
                                .setLoadingGmail(loading: false);
                            Navigator.pushNamed(context, AppRoutes.homePage);
                          },
                        );
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    RichTextWidget(
                        normalText: "Don't Have an Account",
                        highlightedText: "Sign Up",
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignUpPage(),
                              ));
                        }),
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
