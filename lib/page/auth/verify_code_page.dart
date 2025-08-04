import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import '../../res/app_colors.dart';
import '../../res/app_function.dart';
import '../../res/app_images.dart';
import '../../res/app_string.dart';
import '../../res/app_text_style.dart';
import '../../service/provider/auth_manager_provider.dart';
import 'widget/auth_button.dart';
import 'widget/auth_header_section.dart';

/// Login page allowing users to sign in with their phone number (OTP flow).
class VerifyCodePage extends StatefulWidget {
  const VerifyCodePage({
    super.key,
  });

  @override
  State<VerifyCodePage> createState() => _VerifyCodePageState();
}

class _VerifyCodePageState extends State<VerifyCodePage> {
  late String verificationId;
  String otpCode = "";

  @override
  void didChangeDependencies() {
    // Get the verification ID passed via route arguments.
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is String) {
      verificationId = args;
    } else {
      verificationId = '';
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // Access the authentication provider (non-listening)
    final authProvider =
        Provider.of<AuthManageProvider>(context, listen: false);
    // Theme for the PIN input (default).
    final defaultPinTheme = PinTheme(
      width: 60.h,
      height: 60.h,
      textStyle: AppTextStyle.pinNumberTextStyle,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grey),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    // Theme when the PIN input is focused.
    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: AppColors.deepred, width: 2),
      borderRadius: BorderRadius.circular(8),
    );

    // Theme after submitting the PIN.
    final submittedPinTheme = defaultPinTheme.copyWith(
      textStyle:
          AppTextStyle.pinNumberTextStyle.copyWith(color: AppColors.white),
      decoration:
          defaultPinTheme.decoration?.copyWith(color: AppColors.deepred),
    );
    return Scaffold(
        extendBodyBehindAppBar: true,
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /// Header with image and page title/subtitle.
                  const AuthHeaderSection(
                      imageAssetPath: AppImages.otpImage,
                      title: AppString.phoneCodeVerificate,
                      subtitle: AppString.phoneVerificationSubTitle),
                  AppFunction.verticalSpace(30),
                  Pinput(
                    length: 6,
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: focusedPinTheme,
                    submittedPinTheme: submittedPinTheme,
                    showCursor: true,
                    onCompleted: (pin) {
                      otpCode = pin;
                      setState(() {});
                    },
                  ),
                  AppFunction.verticalSpace(30),
                  AuthButton(
                    onPressed: () {
                      if (otpCode.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(AppString.checkVarificateCode),
                          ),
                        );
                        return;
                      }
                      authProvider.verifyOtp(
                        context: context,
                        verificationId: verificationId,
                        smsCode: otpCode,
                      );
                    },
                    label: AppString.verifyPhoneNumber,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
