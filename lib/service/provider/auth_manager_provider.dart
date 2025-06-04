import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../model/profile_model.dart';
import '../../res/app_constant.dart';
import '../../res/app_function.dart';
import '../../res/app_routes.dart';
import '../../res/app_string.dart';
import '../other/auth_repository.dart';
import 'loadingprovider.dart';

class AuthManageProvider with ChangeNotifier {
  LoadingProvider? _loadingProvider;

  /// Set the external loading  (for showing loading indicators)
  void setLoadingProvider(LoadingProvider loadingProvider) {
    _loadingProvider = loadingProvider;
  }

  Future<void> registerUser(
      {required String email,
      required String password,
      required String name,
      required BuildContext context}) async {
    await _withLoading(() async {
      await AuthRepository.firebaseAuth.currentUser?.reload();
      User? user =
          await AuthRepository.registerUser(email: email, password: password);

      if (user == null) {
        AppFunction.toastMessage(AppString.loginFailMessage);
        return;
      }

      // ✅ Build user profile model
      ProfileModel profileModel = ProfileModel(
        uid: user.uid,
        name: name,
        email: email,
        createdAt: Timestamp.now(),
      );
      // ✅ Save profile to Firestore
      await AuthRepository.createUserProfile(
          uid: user.uid, profileModel: profileModel);

      if (!context.mounted) return;
      await _navigateAfterSignIn(
        user.uid,
        context,
        AppString.successSignUpMessage,
      );
    });
  }

  Future<void> loginUser({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    await _withLoading(() async {
      final user =
          await AuthRepository.loginUser(email: email, password: password);

      if (user == null) {
        AppFunction.toastMessage(AppString.loginFailMessage);
        return;
      }
      if (!context.mounted) return;
      await _navigateAfterSignIn(user.uid, context);
    });
  }

  Future<void> sendOtp({
    required String phoneNumber,
    required BuildContext context,
  }) async {
    await _withLoading(() async {
      final verificationId = await AuthRepository.requestPhoneVerification(
        context: context,
        phoneNumber: phoneNumber,
      );

      if (verificationId != null && context.mounted) {
        Navigator.pushNamed(context, AppRoutes.verifiyCodePage,
            arguments: verificationId);
      }
    });
  }

  Future<void> loginWithGoogle({
    required BuildContext context,
  }) async {
    await _withLoading(() async {
      final uid = await AuthRepository.signInWithGoogle();
      if (uid != null) {
        if (!context.mounted) return;
        await _navigateAfterSignIn(uid, context);
      }
    });
  }

  Future<void> verifyOtp({
    required String verificationId,
    required String smsCode,
    required BuildContext context,
  }) async {
    await _withLoading(() async {
      final uid = await AuthRepository.verifySmsCode(
        verificationId: verificationId,
        smsCode: smsCode,
      );

      if (uid != null) {
        if (!context.mounted) return;
        await _navigateAfterSignIn(uid, context);
      }
    });
  }

  /// Shared navigation + success message after sign-in
  Future<void> _navigateAfterSignIn(String uid, BuildContext context,
      [String message = AppString.successSignInMessage]) async {
    await AppConstant.sharedPreferences!
        .setString(AppString.uidSharePrefer, uid);
    AppFunction.toastMessage(message);
    if (!context.mounted) return;
    Navigator.pushReplacementNamed(context, AppRoutes.homePage);
  }

  //Helper to wrap all async methods Loading toggling
  Future<void> _withLoading(Future<void> Function() action) async {
    _loadingProvider?.setUploading(loading: true);
    try {
      await action();
    } catch (e) {
      AppFunction.handleFirebaseAuthError(e);
    } finally {
      _loadingProvider?.setUploading(loading: false);
    }
  }
}
