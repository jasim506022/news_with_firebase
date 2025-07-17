import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../res/app_colors.dart';
import '../../res/app_function.dart';

import '../../res/app_images.dart';
import '../../res/app_routes.dart';
import '../../res/app_string.dart';
import '../../res/validator.dart';
import '../../service/provider/auth_manager_provider.dart';
import '../../widget/custom_text_form_field.dart';
import '../../widget/rich_text_widget.dart';
import 'widget/sign_with_icon_button.dart';
import 'widget/auth_button.dart';
import 'widget/auth_intro_widget.dart';

/// Login page allowing users to sign in using Email/Password, Phone, or Gmail.
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Controllers to manage email and password input fields.
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

// Form key to validate the form inputs.
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _configureStatusBar(); // Set status bar style on page load.
    super.initState();
  }

  @override
  void dispose() {
    // Clean up controllers when the widget is removed from the tree.
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  /// Configures the system UI to set the status bar color and icon brightness.
  void _configureStatusBar() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: AppColors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authProvider =
        Provider.of<AuthManageProvider>(context, listen: false);

    return GestureDetector(
      // Dismiss keyboard when tapping outside input fields.
      onTap: () => FocusScope.of(context).unfocus(),
      child: PopScope(
        canPop: false,
        onPopInvoked: (didPop) async {
          // Show confirmation dialog before exiting the app.
          bool shouldPop =
              await AppFunction.showExitConfirmationDialog(context) ?? false;
          if (shouldPop) SystemNavigator.pop();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColors.white,
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Intro image and title for the login page.
                    const AuthIntroWidget(
                      imageAssetPath: AppImages.appIntroImage,
                      title: AppString.btnLogin,
                      subTitle: AppString.authSubTitle,
                    ),
                    // The email & password form.
                    _buildForm(),
                    AppFunction.verticalSpace(15),
                    AuthButton(
                        onPressed: () {
                          // Validate form before proceeding.
                          if (!_formKey.currentState!.validate()) return;

                          authProvider.loginUser(
                            context: context,
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim(),
                          );
                        },
                        title: AppString.btnLogin),
                    AppFunction.verticalSpace(40),
                    // Alternative login option: Phone number.
                    SignInWithIconButton(
                        iconAssetPath: AppImages.phoneIcon,
                        label: AppString.btnLoginWithPhone,
                        onTap: () => Navigator.pushNamed(
                              context,
                              AppRoutes.loginWithPhoneNumberPage,
                            )),
                    AppFunction.verticalSpace(15),
                    // Alternative login option: Gmail.
                    SignInWithIconButton(
                        iconAssetPath: AppImages.gmailIcon,
                        label: AppString.btnLoginWithGmail,
                        onTap: () =>
                            authProvider.loginWithGoogle(context: context)),

                    AppFunction.verticalSpace(15),
                    RichTextWidget(
                        normalText: AppString.dontHaveAnAccount,
                        highlightedText: AppString.btnSignUp,
                        onTap: () =>
                            Navigator.pushNamed(context, AppRoutes.signUpPage)),
                    AppFunction.verticalSpace(200),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Form _buildForm() {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            CustomTextFormField(
              label: AppString.emailLabel,
              controller: _emailController,
              hintText: AppString.emailHint,
              obscureText: false,
              textInputType: TextInputType.emailAddress,
              validator: Validators.validateEmail,
            ),
            CustomTextFormField(
              hasPasswordToggle: true,
              obscureText: false,
              label: AppString.passwordLabel,
              controller: _passwordController,
              hintText: AppString.passwordHint,
              textInputType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
              validator: Validators.validatePassword,
            ),
          ],
        ));
  }
}
