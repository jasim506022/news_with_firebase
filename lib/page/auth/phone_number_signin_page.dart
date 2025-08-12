import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';
import '../../res/app_colors.dart';
import '../../res/app_function.dart';
import '../../res/app_images.dart';
import '../../res/app_string.dart';
import '../../res/app_text_style.dart';
import '../../res/validator.dart';
import '../../service/provider/auth_manager_provider.dart';
import '../../widget/custom_text_field.dart';
import 'widget/auth_button.dart';
import 'widget/auth_header_section.dart';

/// A page for phone number authentication.
///
/// This page allows the user to enter their phone number and
/// request an OTP for verification.
///
/// Workflow:
/// 1. User enters phone number.
/// 2. Presses "Send Code".
/// 3. Calls `sendOtp()` in [AuthManagerProvider].
class PhoneNumberSignInPage extends StatefulWidget {
  const PhoneNumberSignInPage({super.key});

  @override
  State<PhoneNumberSignInPage> createState() => _PhoneNumberSignInPageState();
}

class _PhoneNumberSignInPageState extends State<PhoneNumberSignInPage> {
  /// Controller for the phone number input field.
  final TextEditingController phoneNumberController = TextEditingController();

  /// Key to manage and validate the form.
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    /// Dispose the controller to free up memory.
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get the authentication provider without listening for changes.
    final authProvider =
        Provider.of<AuthManageProvider>(context, listen: false);

    return GestureDetector(
      /// Dismiss the keyboard when tapping outside.
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: Scaffold(
          body: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /// Header with image and page title/subtitle
                  const AuthHeaderSection(
                    imageAssetPath: AppImages.phoneIntroImage,
                    title: AppString.phoneVerificationTitle,
                    subtitle: AppString.phoneVerificationSubTitle,
                  ),
                  AppFunction.verticalSpace(30),
                  // Form to input the phone number.
                  _buildPhoneNumberForm(),
                  AppFunction.verticalSpace(20),
                  // Button to send the verification code.
                  AuthButton(
                      onPressed: () {
                        if (!_formKey.currentState!.validate()) return;

                        authProvider.sendOtp(
                            phoneNumber: phoneNumberController.text,
                            context: context);
                      },
                      label: AppString.btnSendCode),
                  AppFunction.verticalSpace(50),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the phone number input field
  Form _buildPhoneNumberForm() {
    return Form(
      key: _formKey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppFunction.horizontalSpace(10),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r),
                border: Border.all(color: AppColors.grey, width: 1)),
            child: Text(
              AppString.countryCode,
              style: AppTextStyle.titleTextStyle(context),
            ),
          ),
          AppFunction.horizontalSpace(10),
          Expanded(
              child: CustomTextField(
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.phone,
                  hintText: AppString.phoneHint,
                  maxLength: 10,
                  validator: Validators.validatePhoneNumber,
                  controller: phoneNumberController))
        ],
      ),
    );
  }
}
