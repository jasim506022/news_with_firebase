import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';

import '../../res/app_colors.dart';
import '../../res/app_function.dart';
import '../../res/app_images.dart';
import '../../res/app_string.dart';

import '../../res/validator.dart';
import '../../service/provider/auth_manager_provider.dart';
import '../../widget/custom_text_form_field.dart';
import '../../widget/rich_text_widget.dart';
import 'widget/auth_button.dart';
import 'widget/auth_intro_widget.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // Controllers for input fields
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  // Form key for validation
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // Always dispose all controllers
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  // Top image and title

                  const AuthIntroWidget(
                    imageAssetPath: AppImages.appIntroImage,
                    title: AppString.btnSignUp,
                    subTitle: AppString.authSubTitle,
                  ),
                  _buildForm(),
                  AppFunction.verticalSpace(15),
                  // Sign Up button
                  AuthButton(
                      onPressed: () {
                        if (!_formKey.currentState!.validate()) return;

                        authProvider.registerUser(
                            context: context,
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim(),
                            name: _nameController.text.trim());
                      },
                      title: AppString.btnSignUp),
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

  // Build the form with validation
  Form _buildForm() {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            CustomTextFormField(
              textInputType: TextInputType.name,
              label: AppString.nameLabel,
              controller: _nameController,
              hintText: AppString.nameHint,
              validator: Validators.validateName,
            ),
            CustomTextFormField(
              textInputType: TextInputType.emailAddress,
              label: AppString.emailLabel,
              controller: _emailController,
              hintText: AppString.emailHint,
              validator: Validators.validateEmail,
            ),
            CustomTextFormField(
              label: AppString.passwordLabel,
              controller: _passwordController,
              hintText: AppString.passwordHint,
              hasPasswordToggle: true,
              validator: Validators.validatePassword,
            ),
            CustomTextFormField(
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
