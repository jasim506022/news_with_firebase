import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../res/app_text_style.dart';
import '../../../res/network_utilis.dart';
import '../../../service/provider/loadingprovider.dart';

/// A reusable button widget for authentication actions.
/// Shows a loading indicator while an async operation is in progress.
class AuthButton extends StatelessWidget {
  const AuthButton({
    super.key,
    required this.onPressed,
    required this.label,
  });

  final VoidCallback onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Consumer<LoadingProvider>(
        builder: (context, loadingProvider, value) => SizedBox(
              height: 55.h,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => NetworkUtils.executeWithInternetCheck(
                    action: onPressed, context: context),
                child: loadingProvider.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : Text(label, style: AppTextStyle.buttonTextStyle()),
              ),
            ));
  }
}
