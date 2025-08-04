import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';

import '../../res/app_colors.dart';
import '../../res/app_function.dart';
import '../../res/app_images.dart';
import '../../res/app_string.dart';

import '../../res/validator.dart';
import '../../service/provider/auth_manager_provider.dart';
import '../../widget/custom_text_field.dart';
import '../../widget/rich_text_widget.dart';
import 'widget/auth_button.dart';
import 'widget/auth_header_section.dart';

/// SignUpPage allows new users to register by providing
/// their name, email, password, and confirming password.
/// Includes form validation and navigation to Login page.
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // Controllers to manage email and password, name input fields.
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController =
      TextEditingController(); // Difference
  final _confirmPasswordController = TextEditingController();

  // Form key to validate the form inputs.
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // Clean up controllers when the widget is removed from the tree.
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Access the authentication provider (non-listening)
    final authProvider =
        Provider.of<AuthManageProvider>(context, listen: false);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /// Header with image and page title/subtitle
                  const AuthHeaderSection(
                    imageAssetPath: AppImages.appIntroImage,
                    title: AppString.btnSignUp,
                    subtitle: AppString.authSubTitle,
                  ),

                  _buildSignUpForm(),
                  AppFunction.verticalSpace(15),

                  /// Main Sign Up button

                  AuthButton(
                      onPressed: () {
                        if (!_formKey.currentState!.validate()) return;
                        // Validate form before proceeding.
                        authProvider.registerNewUser(
                            context: context,
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim(),
                            name: _nameController.text.trim());
                      },
                      label: AppString.btnSignUp),
                  AppFunction.verticalSpace(15),
                  // Navigation to Login
                  RichTextWidget(
                    normalText: AppString.alreadHaveAAcount,
                    highlightedText: AppString.btnLogin,
                    onTap: () => Navigator.pop(context),
                  ),
                  AppFunction.verticalSpace(200),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Builds the sign-up form fields with validation for:
  /// - Name
  /// - Email
  /// - Password
  /// - Confirm Password
  Form _buildSignUpForm() {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            CustomTextField(
              textInputType: TextInputType.name,
              label: AppString.nameLabel,
              controller: _nameController,
              hintText: AppString.nameHint,
              validator: Validators.validateName,
            ),
            CustomTextField(
              textInputType: TextInputType.emailAddress,
              label: AppString.emailLabel,
              controller: _emailController,
              hintText: AppString.emailHint,
              validator: Validators.validateEmail,
            ),
            CustomTextField(
              label: AppString.passwordLabel,
              controller: _passwordController,
              hintText: AppString.passwordHint,
              hasPasswordToggle: true,
              validator: Validators.validatePassword,
            ),
            CustomTextField(
              label: AppString.passwordConfirmLabel,
              controller: _confirmPasswordController,
              hintText: AppString.confirmPasswordHint,
              hasPasswordToggle: true,
              validator: (value) => Validators.validateConfirmPassword(
                  value, _passwordController.text.trim()),
            ),
          ],
        ));
  }
}
