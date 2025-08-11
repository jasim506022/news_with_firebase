import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
  void setLoadingProvider(LoadingProvider loadingProvider) =>
      _loadingProvider = loadingProvider;

  Future<void> getUser() async {
    var snapshot = await FirebaseFirestore.instance
        .collection(AppString.userCollection)
        .doc(
            AppConstants.sharedPreferences!.getString(AppString.uidSharePrefer))
        .get();

    if (snapshot.exists) {
      final profileModel = ProfileModel.fromMap(snapshot.data()!);
      if (kDebugMode) {
        print(profileModel.email);
      }
      await AppConstants.sharedPreferences!
          .setString(AppString.nameSharePrefer, profileModel.name!);
      await AppConstants.sharedPreferences!
          .setString(AppString.emailSharePrefer, profileModel.email!);

      await AppConstants.sharedPreferences!
          .setBool(AppString.setDataShareprefer, true);
    } else {}
  }

  /// Handles user registration, profile creation, and post-sign-up navigation
  Future<void> registerNewUser(
      {required String email,
      required String password,
      required String name,
      required BuildContext context}) async {
    await _executeWithLoading(() async {
      // Reload current user (safety check, often optional during registration)
      await AuthRepository.firebaseAuth.currentUser?.reload();
      var user =
          await AuthRepository.registerUser(email: email, password: password);

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
      await AuthRepository.createUserProfile(
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

  /// Authenticates a user using email and password.
  ///
  /// - Shows loading during the process.
  /// - Displays an error toast if login fails.
  /// - Navigates to the next screen on success.
  Future<void> loginWithEmailAndPassword({
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

  Future<void> verifyOtp({
    required String verificationId,
    required String smsCode,
    required BuildContext context,
  }) async {
    await _executeWithLoading(() async {
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

  /// Handles post-sign-in tasks: storing UID, showing success message, and navigating to home screen.
  Future<void> _navigateAfterSignIn(String uid, BuildContext context,
      [String message = AppString.successSignInMessage]) async {
    // Save the user ID to shared preferences
    await AppConstants.sharedPreferences!
        .setString(AppString.uidSharePrefer, uid);
    await AppConstants.sharedPreferences!
        .setBool(AppString.setDataShareprefer, false);
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

  /// Signs out the current user using [AuthRepository].
  /// Catches and handles Firebase authentication errors gracefully.
  Future<void> logOut(BuildContext context) async {
    try {
      await AuthRepository.signOut();
      Navigator.pushNamedAndRemoveUntil(
        // ignore: use_build_context_synchronously
        context,
        AppRoutes.signInPage,
        (route) => false,
      );
      await AppConstants.sharedPreferences!
          .setBool(AppString.setDataShareprefer, false);
      await AppConstants.sharedPreferences!
          .setString(AppString.uidSharePrefer, "");

      await AppConstants.sharedPreferences!
          .setString(AppString.nameSharePrefer, "");

      await AppConstants.sharedPreferences!
          .setString(AppString.emailSharePrefer, "");
    } catch (e) {
      AppFunction.handleFirebaseAuthError(e);
    }
  }
}
