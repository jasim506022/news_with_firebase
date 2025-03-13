import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:newsapps/model/profile_model.dart';
import 'package:newsapps/res/app_string.dart';
import 'package:newsapps/service/provider/loadingprovider.dart';

import '../../res/app_function.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  LoadingProvider? _loadingProvider;

  User? _user;
  User? get user => _user;
  bool get isAuthenticated => _user != null;

  // Set LoadingProvider
  void setLoadingProvider(LoadingProvider loadingProvider) {
    _loadingProvider = loadingProvider;
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String name,
    required BuildContext context,
  }) async {
    try {
      // Set loading state to true
      _loadingProvider?.setUploading(loading: true);

      // Create user with email and password
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Ensure the user object is correctly fetched
      await _firebaseAuth.currentUser?.reload();
      User? user = userCredential.user;

      if (user != null) {
        // Create profile model
        ProfileModel profileModel = ProfileModel(
          uid: user.uid,
          name: name,
          email: email,
          createdAt: Timestamp.now(),
        );

        // Save user data to Firestore
        await _firebaseFirestore
            .collection("users")
            .doc(user.uid)
            .set(profileModel.toMap());

        // Show success message
        AppFunction.toastMessage(AppString.successSignUpMessage);

        // Navigate to home page (uncomment when needed)
        // Navigator.pushReplacementNamed(context, HomePage.routeName);
      }
    } on FirebaseAuthException catch (e) {
      // Handle Firebase specific errors
      if (e.code == 'email-already-in-use') {
        AppFunction.toastMessage('Email is already in use. Try logging in.');
      } else if (e.code == 'weak-password') {
        AppFunction.toastMessage('The password provided is too weak.');
      } else {
        AppFunction.toastMessage('Signup failed: ${e.message}');
      }
    } catch (e) {
      // Log any other errors
      debugPrint('Error in signUp: $e');
      AppFunction.toastMessage('Something went wrong. Please try again.');
    } finally {
      // Set loading state to false
      _loadingProvider?.setUploading(loading: false);
    }
  }
}
