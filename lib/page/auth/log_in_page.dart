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
import '../../widget/custom_text_field.dart';
import '../../widget/rich_text_widget.dart';
import 'widget/icon_text_button.dart';
import 'widget/auth_button.dart';
import 'widget/auth_header_section.dart';

/// LoginPage allows users to sign in using email/password, phone number, or Google.
/// Includes form validation, navigation to sign up, and exit confirmation.

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
    // Set status bar style on page load.
    _setStatusBarStyle();
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
  void _setStatusBarStyle() =>
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: AppColors.white,
        statusBarIconBrightness: Brightness.dark,
      ));

  @override
  Widget build(BuildContext context) {
    // Access the authentication provider (non-listening)
    final authProvider =
        Provider.of<AuthManageProvider>(context, listen: false);

    return GestureDetector(
      // Dismiss keyboard when tapping outside input fields.
      onTap: () => FocusScope.of(context).unfocus(),
      child: PopScope(
        canPop: false,
        onPopInvoked: (didPop) async {
          // Show confirmation dialog before exiting the app.
          bool confirmExit =
              await AppFunction.showExitConfirmationDialog(context) ?? false;
          if (confirmExit) SystemNavigator.pop(); // Close app
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColors.white,
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// Displays intro image and text
                const AuthHeaderSection(
                  imageAssetPath: AppImages.appIntroImage,
                  title: AppString.btnLogin,
                  subtitle: AppString.authSubTitle,
                ),

                /// Login form containing email & password input
                _buildEmailPasswordForm(),
                AppFunction.verticalSpace(15),

                /// Main login button
                AuthButton(
                    onPressed: () {
                      // Validate form before proceeding.
                      if (!_formKey.currentState!.validate()) return;
                      authProvider.loginWithEmailAndPassword(
                        context: context,
                        email: _emailController.text.trim(),
                        password: _passwordController.text.trim(),
                      );
                    },
                    label: AppString.btnLogin),
                AppFunction.verticalSpace(40),

                // Alternative login option: Phone number.
                IconTextButton(
                    iconAssetPath: AppImages.phoneIcon,
                    label: AppString.btnLoginWithPhone,
                    onTap: () => Navigator.pushNamed(
                          context,
                          AppRoutes.loginWithPhoneNumberPage,
                        )),
                AppFunction.verticalSpace(15),
                // Alternative login option: Gmail.
                IconTextButton(
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
    );
  }

  /// Builds the login form containing:
  /// - Email input field
  /// - Password input field (with toggle visibility)
  Form _buildEmailPasswordForm() => Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextField(
            label: AppString.emailLabel,
            controller: _emailController,
            hintText: AppString.emailHint,
            obscureText: false,
            textInputType: TextInputType.emailAddress,
            validator: Validators.validateEmail,
          ),
          CustomTextField(
            hasPasswordToggle: true,
            obscureText: true,
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
