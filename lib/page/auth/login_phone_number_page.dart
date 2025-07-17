import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsapps/res/app_colors.dart';

import 'package:provider/provider.dart';
import '../../res/app_function.dart';
import '../../res/app_images.dart';
import '../../res/app_string.dart';
import '../../res/app_text_style.dart';
import '../../res/validator.dart';
import '../../service/provider/auth_manager_provider.dart';
import '../../widget/custom_text_form_field.dart';
import 'widget/auth_button.dart';
import 'widget/auth_intro_widget.dart';

/// Login page allowing users to sign in with their phone number (OTP flow).

class LoginPhoneNumberPage extends StatefulWidget {
  const LoginPhoneNumberPage({super.key});

  @override
  State<LoginPhoneNumberPage> createState() => _LoginPhoneNumberPageState();
}

class _LoginPhoneNumberPageState extends State<LoginPhoneNumberPage> {
  // Controller to handle phone number input.
  final _phoneController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // Form key to validate input.
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get AuthProvider once to avoid duplication.
    final authProvider =
        Provider.of<AuthManageProvider>(context, listen: false);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: Scaffold(
          body: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Intro section with image, title, and subtitle.
                    const AuthIntroWidget(
                      imageAssetPath: AppImages.phoneIntroImage,
                      title: AppString.phoneVerificationTitle,
                      subTitle: AppString.phoneVerificationSubTitle,
                    ),
                    AppFunction.verticalSpace(30),
                    // Form to input the phone number.
                    _buildForm(),
                    AppFunction.verticalSpace(20),
                    // Button to send the verification code.
                    AuthButton(
                        onPressed: () {
                          if (!_formKey.currentState!.validate()) return;

                          authProvider.sendOtp(
                              phoneNumber: _phoneController.text,
                              context: context);
                        },
                        title: AppString.btnSendCode),
                    AppFunction.verticalSpace(50),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppFunction.horizontalSpace(10),
          Text(
            AppString.countryCode,
            style: AppTextStyle.titleTextStyle(context),
          ),
          Text(
            "|",
            style: TextStyle(fontSize: 20, color: AppColors.grey),
          ),
          AppFunction.horizontalSpace(10),
          Expanded(
              child: CustomTextFormField(
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.phone,
                  hintText: AppString.phoneHint,
                  maxLength: 10,
                  validator: Validators.validatePhoneNumber,
                  controller: _phoneController))
        ],
      ),
    );
  }
}
