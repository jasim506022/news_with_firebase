import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../model/profile_model.dart';
import '../../res/app_constant.dart';
import '../../res/app_function.dart';
import '../../res/app_string.dart';

class AuthRepository {
  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Register user with email & password
  static Future<User?> registerUser(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } catch (e) {
      AppFunction.handleFirebaseAuthError(e);
      rethrow;
    }
  }

  //Upload user profile data to Firestore
  static Future<void> createUserProfile(
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

  // Login user with email & password
  static Future<User?> loginUser(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } catch (e) {
      AppFunction.handleFirebaseAuthError(e);
      rethrow;
    }
  }

  // Verify phone number
  static Future<String?> requestPhoneVerification(
      {required String phoneNumber, required BuildContext context}) async {
    Completer<String?> completer = Completer();

    try {
      await firebaseAuth.verifyPhoneNumber(
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

  // Verify OTP code from user input
  static Future<String?> verifySmsCode(
      {required String verificationId, required String smsCode}) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      UserCredential userCredential =
          await firebaseAuth.signInWithCredential(credential);
      return userCredential.user?.uid;
    } catch (e) {
      AppFunction.toastMessage('OTP verification failed: ${e.toString()}');
      rethrow;
    }
  }

  // Sign in using Google account
  static Future<String?> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final User? user =
          (await firebaseAuth.signInWithCredential(credential)).user;
      AppConstant.sharedPreferences!.setString("uid", user!.uid);

      return user.uid;
    } catch (e) {
      AppFunction.handleFirebaseAuthError(e);
      rethrow;
    }
  }

  // Log out user
  Future<void> signOut() async => await firebaseAuth.signOut();
}
