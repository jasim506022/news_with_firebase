import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../model/profile_model.dart';
import '../../res/app_constant.dart';
import '../../res/app_function.dart';
import '../../res/app_string.dart';

/// A repository class responsible for handling all authentication and
/// user-related Firestore operations.
///
/// This includes:
/// - Email/Password authentication
/// - Phone number verification
/// - Google sign-in
/// - User profile management in Firestore
///
/// Centralizing authentication logic here ensures easy maintenance,
/// cleaner UI code, and consistent error handling across the app.

class AuthRepository {
  // Firebase Authentication instance
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  // Firestore instance
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static FirebaseAuth get auth => _auth;
  static FirebaseFirestore get firestore => _firestore;

  /// Retrieves the current logged-in user's profile data from Firestore.
  ///
  /// Returns a [ProfileModel] if data exists, otherwise `null`.
  static Future<ProfileModel?> getUserProfile() async {
    try {
      final uid =
          AppConstants.sharedPreferences?.getString(AppString.uidSharePrefer);

      if (uid == null) return null;

      final snapshot =
          await _firestore.collection(AppString.userCollection).doc(uid).get();

      if (snapshot.exists && snapshot.data() != null) {
        return ProfileModel.fromMap(snapshot.data()!);
      }

      return null;
    } catch (e) {
      AppFunction.handleFirebaseAuthError(e);
      rethrow;
    }
  }

  /// Registers a new user with [email] and [password].
  /// Returns the created [User] on success.
  static Future<User?> registerWithEmail(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } catch (e) {
      AppFunction.handleFirebaseAuthError(e);
      rethrow;
    }
  }

  /// Logs in an existing user with [email] and [password].
  /// Returns the authenticated [User] on success.
  static Future<void> saveUserProfile(
      {required String uid, required ProfileModel profileModel}) async {
    try {
      await _firestore
          .collection(AppString.userCollection)
          .doc(uid)
          .set(profileModel.toMap());
    } catch (e) {
      AppFunction.handleFirebaseAuthError(e);
      rethrow;
    }
  }

  /// Logs in an existing user with [email] and [password].
  /// Returns the authenticated [User] on success.
  static Future<User?> loginUser(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } catch (e) {
      AppFunction.handleFirebaseAuthError(e);
      rethrow;
    }
  }

  /// Sends a phone number verification code via SMS.
  ///
  /// Returns the [verificationId] if successful.
  static Future<String?> requestPhoneVerification(
      {required String phoneNumber, required BuildContext context}) async {
    Completer<String?> completer = Completer();

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: AppString.countryCode + phoneNumber,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {},
        verificationFailed: (FirebaseAuthException e) {
          AppFunction.handleFirebaseAuthError(e);
        },
        codeSent: (String verificationId, int? forceResendingToken) {
          completer.complete(verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          debugPrint(
              'Auto retrieval timeout. Verification ID: $verificationId');
          AppFunction.toastMessage(AppString.codeAutoRetrievalTimeout);
        },
      );
      return completer.future;
    } catch (e) {
      AppFunction.toastMessage(
          'Something went wrong while sending verification code.');
      rethrow;
    }
  }

  /// Verifies the OTP [smsCode] for a given [verificationId].
  ///
  /// Returns the authenticated user's UID if successful.
  static Future<String?> verifyOtpCode(
      {required String verificationId, required String smsCode}) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      return userCredential.user?.uid;
    } catch (e) {
      AppFunction.toastMessage('OTP verification failed: ${e.toString()}');
      rethrow;
    }
  }

  /// Signs in the user using their Google account.
  ///
  /// Returns the authenticated user's UID if successful.
  static Future<String?> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) return null; // User cancelled login

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final User? user = (await _auth.signInWithCredential(credential)).user;
      AppConstants.sharedPreferences!.setString("uid", user!.uid);

      return user.uid;
    } catch (e) {
      AppFunction.handleFirebaseAuthError(e);
      rethrow;
    }
  }

  /// Signs out the current user from Firebase Authentication.
  /// Catches errors, handles them, and rethrows for further handling if needed.
  static Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      AppFunction.handleFirebaseAuthError(e);
      rethrow;
    }
  }
}
