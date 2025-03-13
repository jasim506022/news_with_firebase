import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../res/app_colors.dart';
import '../../res/app_string.dart';

import '../../res/validator.dart';
import '../../service/provider/auth_provider.dart';
import '../../widget/newstextfieldwidget.dart';
import '../../widget/rich_text_widget.dart';
import 'widget/auth_button.dart';
import 'widget/auth_intro_widget.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final _form = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
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
                              textInputType: TextInputType.name,
                              label: AppString.nameLabel,
                              controller: nameController,
                              hintText: AppString.nameHint,
                              validator: Validators.validateName,
                            ),
                            CustomTextFormField(
                              textInputType: TextInputType.emailAddress,
                              label: AppString.emailLabel,
                              controller: emailController,
                              hintText: AppString.emailHint,
                              validator: Validators.validateEmail,
                            ),
                            CustomTextFormField(
                              label: AppString.passwordLabel,
                              controller: passwordController,
                              hintText: AppString.passwordHint,
                              hasPasswordToggle: true,
                              validator: Validators.validatePassword,
                            ),
                            CustomTextFormField(
                              label: AppString.passwordConfirmLabel,
                              controller: confirmPasswordController,
                              hintText: AppString.confirmPasswordHint,
                              hasPasswordToggle: true,
                              validator: (value) =>
                                  Validators.validateConfirmPassword(
                                      value, passwordController.text.trim()),
                            ),
                          ],
                        )),
                    const SizedBox(
                      height: 15,
                    ),
                    AuthButton(
                        onPressed: () {
                          // if (!_form.currentState!.validate()) return;
                          final authProvider =
                              Provider.of<AuthProvider>(context, listen: false);
                          authProvider.signUp(
                              context: context,
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                              name: nameController.text.trim());
                        },
                        title: AppString.btnSignUp),
                    const SizedBox(
                      height: 15,
                    ),
                    RichTextWidget(
                      normalText: AppString.alreadHaveAAcount,
                      highlightedText: AppString.btnLogin,
                      onTap: () {
                        Navigator.pop(context);
                      },
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



/*
#: Focus Node
*/


/*
                    Consumer<LoadingProvider>(
                      builder: (context, loadingProvider, child) {
                        return 
                        
                        RoundButton(
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

*/

/*
diffent Provider.of<LoadingProvider>(context,
                                      listen: false) and true:
                                      */