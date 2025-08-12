import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import '../../model/profile_model.dart';
import '../../res/app_constant.dart';
import '../../res/app_function.dart';
import '../../res/app_routes.dart';
import '../../res/app_string.dart';
import '../other/auth_repository.dart';
import 'loadingprovider.dart';

/// Provider that handles authentication-related logic, state management,
/// and navigation after authentication actions.
///
/// Uses [AuthRepository] for Firebase operations and [LoadingProvider]
/// for showing/hiding loading indicators.

class AuthManageProvider with ChangeNotifier {
  LoadingProvider? _loadingProvider;

  /// Links a [LoadingProvider] to this provider for showing progress indicators.
  void setLoadingProvider(LoadingProvider loadingProvider) =>
      _loadingProvider = loadingProvider;

  /// Fetches the logged-in user's profile from Firestore
  /// and stores it in shared preferences.
  Future<void> getUserProfile() async {
    await _executeWithLoading(
      () async {
        final profileModel = await AuthRepository.getUserProfile();
        final prefs = AppConstants.sharedPreferences!;
        await Future.wait([
          prefs.setString(AppString.nameSharePrefer, profileModel!.name ?? ''),
          prefs.setString(AppString.emailSharePrefer, profileModel.email ?? ''),
          prefs.setBool(AppString.setDataShareprefer, true),
        ]);
      },
    );
  }

  /// Registers a new user, creates their profile in Firestore,
  /// and navigates to the home screen.
  Future<void> registerNewUser(
      {required String email,
      required String password,
      required String name,
      required BuildContext context}) async {
    await _executeWithLoading(() async {
      // Reload current user (safety check, often optional during registration)
      await AuthRepository.auth.currentUser?.reload();
      var user = await AuthRepository.registerWithEmail(
          email: email, password: password);

      if (user == null) {
        AppFunction.toastMessage(AppString.loginFailMessage);
        return;
      }

      // Create user profile data
      ProfileModel profileModel = ProfileModel(
        uid: user.uid,
        name: name,
        email: email,
        createdAt: Timestamp.now(),
      );
      // Save user profile to Firestore
      await AuthRepository.saveUserProfile(
          uid: user.uid, profileModel: profileModel);

      if (!context.mounted) return;
      // Navigate to home screen with success message
      await _navigateAfterSignIn(
        user.uid,
        context,
        AppString.successSignUpMessage,
      );
    });
  }

  /// Logs in a user with email and password,
  /// shows an error if login fails
  Future<void> signinWithEmailAndPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    await _executeWithLoading(() async {
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

  /// Sends OTP to the provided phone number and navigates to verification page.
  Future<void> sendOtp({
    required String phoneNumber,
    required BuildContext context,
  }) async {
    await _executeWithLoading(() async {
      final verificationId = await AuthRepository.requestPhoneVerification(
        context: context,
        phoneNumber: phoneNumber,
      );

      if (verificationId != null && context.mounted) {
        Navigator.pushNamed(context, AppRoutes.verifyCodePage,
            arguments: verificationId);
      }
    });
  }

  /// Signs in with Google and navigates to home page on success.
  Future<void> loginWithGoogle({
    required BuildContext context,
  }) async {
    await _executeWithLoading(() async {
      final uid = await AuthRepository.signInWithGoogle();
      if (uid != null) {
        if (!context.mounted) return;
        await _navigateAfterSignIn(uid, context);
      }
    });
  }

  /// Verifies OTP code and navigates to home page on success.
  Future<void> verifyOtp({
    required String verificationId,
    required String smsCode,
    required BuildContext context,
  }) async {
    await _executeWithLoading(() async {
      final uid = await AuthRepository.verifyOtpCode(
        verificationId: verificationId,
        smsCode: smsCode,
      );

      if (uid != null) {
        if (!context.mounted) return;
        await _navigateAfterSignIn(uid, context);
      }
    });
  }

  /// Signs out the current user using [AuthRepository].
  /// Catches and handles Firebase authentication errors gracefully.
  Future<void> signOut(BuildContext context) async {
    _executeWithLoading(
      () async {
        await AuthRepository.signOut();

        await _clearUserPrefs();
        if (!context.mounted) return;
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.signInPage,
          (_) => false,
        );
      },
    );
  }

  Future<void> _clearUserPrefs() async {
    final prefs = AppConstants.sharedPreferences!;

    await Future.wait([
      prefs.setBool(AppString.setDataShareprefer, false),
      prefs.setString(AppString.uidSharePrefer, ''),
      prefs.setString(AppString.nameSharePrefer, ''),
      prefs.setString(AppString.emailSharePrefer, ''),
    ]);
  }

  /// Handles post-sign-in tasks: storing UID, showing success message, and navigating to home screen.
  Future<void> _navigateAfterSignIn(String uid, BuildContext context,
      [String message = AppString.successSignInMessage]) async {
    // Save the user ID to shared preferences
    final prefs = AppConstants.sharedPreferences!;

    await Future.wait([
      prefs.setString(AppString.uidSharePrefer, uid),
      prefs.setBool(AppString.setDataShareprefer, false),
    ]);

    AppFunction.toastMessage(message);
    if (!context.mounted) return;
    // Navigate to the home page, replacing the sign-in screen
    Navigator.pushReplacementNamed(context, AppRoutes.homePage);
  }

  /// Executes an asynchronous action while toggling the loading state.
  ///
  /// - Sets `loading` to `true` before the action.
  /// - Catches any exceptions and delegates error handling.
  /// - Resets `loading` to `false` in all cases (finally).
  Future<void> _executeWithLoading(
      Future<void> Function() asyncOperation) async {
    _loadingProvider?.setUploading(loading: true);
    try {
      await asyncOperation();
    } catch (error) {
      AppFunction.handleFirebaseAuthError(error);
    } finally {
      _loadingProvider?.setUploading(loading: false);
    }
  }
}
