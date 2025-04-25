import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_hub/constant/colors/colors.dart';
import 'package:event_hub/views/bottom_naivgation_bar_screen.dart';
import 'package:event_hub/views/sign_in_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  var isRegisterLoading = false.obs;
  var isLoginLoading = false.obs;
  var isGoogleLoading = false.obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  TextEditingController emailController = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  final RxBool isSecureText = true.obs;
  void toggleSecureText() {
    isSecureText.value = !isSecureText.value;
  }

  void register() async {
    try {
      if (passwordController.text != confirmpasswordController.text) {
        Get.snackbar("Password Error", "Passwords do not match",
            backgroundColor: AppColors.redColor,
            snackPosition: SnackPosition.BOTTOM,
            titleText: Text(
              "Password Mismatch",
              style: GoogleFonts.montserrat(color: AppColors.whiteColor),
            ),
            messageText: Text(
              "Please ensure both passwords are the same.",
              style: GoogleFonts.montserrat(color: AppColors.whiteColor),
            ));
        return;
      }

      // Only set register loading to true
      isRegisterLoading(true);

      var credentials = await auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      if (credentials.user != null) {
        await FirebaseFirestore.instance
            .collection("users")
            .doc(credentials.user!.uid)
            .set({
          "username": username.text,
          "email": emailController.text,
          "uid": credentials.user!.uid,
          "createdAt": FieldValue.serverTimestamp(),
        });

        Get.snackbar("Success", "Account created successfully",
            backgroundColor: Colors.green, snackPosition: SnackPosition.BOTTOM);

        Get.off(() => BottomNavigationBarScreen());
      } else {
        Get.snackbar("Registration Failed", "User could not be created",
            backgroundColor: AppColors.redColor,
            snackPosition: SnackPosition.BOTTOM,
            titleText: Text(
              "Account Creation Failed",
              style: GoogleFonts.montserrat(
                color: AppColors.whiteColor,
              ),
            ),
            messageText: Text(
              "There was an issue with creating your account. Please try again.",
              style: GoogleFonts.montserrat(
                color: AppColors.whiteColor,
              ),
            ));
      }
    } catch (e) {
      String errorMessage = "An error occurred during registration.";
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'email-already-in-use':
            errorMessage = "This email is already registered.";
            break;
          case 'invalid-email':
            errorMessage = "Please provide a valid email address.";
            break;
          case 'weak-password':
            errorMessage =
                "Password is too weak. Please use a stronger password.";
            break;
          default:
            errorMessage = e.message ?? "Authentication failed.";
            break;
        }
      }

      Get.snackbar("Registration Failed", errorMessage,
          backgroundColor: AppColors.redColor,
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isRegisterLoading(false);
    }
  }

  // login
  void login() async {
    try {
      isLoginLoading(true);
      await auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      Get.offAll(() => BottomNavigationBarScreen());
    } catch (e) {
      String errorMessage = "Failed to sign in. Please check your credentials.";
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'user-not-found':
            errorMessage = "No user found with this email.";
            break;
          case 'wrong-password':
            errorMessage = "Wrong password provided.";
            break;
          case 'invalid-email':
            errorMessage = "Please provide a valid email address.";
            break;
          case 'user-disabled':
            errorMessage = "This user account has been disabled.";
            break;
          default:
            errorMessage = e.message ?? "Authentication failed.";
            break;
        }
      }

      Get.snackbar("Login Failed", errorMessage,
          backgroundColor: AppColors.redColor,
          snackPosition: SnackPosition.BOTTOM,
          titleText: Text(
            "Login Failed",
            style: GoogleFonts.montserrat(
              color: AppColors.whiteColor,
            ),
          ),
          messageText: Text(
            errorMessage,
            style: GoogleFonts.montserrat(
              color: AppColors.whiteColor,
            ),
          ));
    } finally {
      isLoginLoading(false);
    }
  }

  Future<UserCredential?> loginWithGoogle() async {
    try {
      isGoogleLoading(true);

      if (_googleSignIn == null) {
        _googleSignIn = GoogleSignIn();
      }

      // Add debug logs
      print("Starting Google Sign-In process");

      // Try to sign in
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      // Debug
      print(
          "Google Sign-In result: ${googleUser != null ? 'Success' : 'Cancelled or Failed'}");

      if (googleUser == null) {
        Get.snackbar("Sign-in Cancelled", "Google sign-in was cancelled",
            backgroundColor: Colors.orange,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM);
        return null;
      }
      print("Getting authentication details for: ${googleUser.email}");
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      print("Access token obtained: ${googleAuth.accessToken != null}");
      print("ID token obtained: ${googleAuth.idToken != null}");
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      try {
        print("Attempting to sign in with Firebase using Google credential");
        final userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        print("Firebase sign-in successful: ${userCredential.user?.email}");
        if (userCredential.additionalUserInfo?.isNewUser ?? false) {
          print("New user detected, saving to Firestore");
          await FirebaseFirestore.instance
              .collection("users")
              .doc(userCredential.user!.uid)
              .set({
            "username": userCredential.user!.displayName ?? "",
            "email": userCredential.user!.email ?? "",
            "uid": userCredential.user!.uid,
            "photoUrl": userCredential.user!.photoURL,
            "createdAt": FieldValue.serverTimestamp(),
            "provider": "google"
          });
        }
        Get.offAll(() => BottomNavigationBarScreen());
        return userCredential;
      } on FirebaseAuthException catch (e) {
        print("Firebase Auth Exception: ${e.code} - ${e.message}");
        String errorMessage = "Failed to sign in with Google.";
        switch (e.code) {
          case 'account-exists-with-different-credential':
            errorMessage =
                "An account already exists with the same email address but different sign-in credentials.";
            break;
          case 'invalid-credential':
            errorMessage = "The credential is malformed or has expired.";
            break;
          case 'operation-not-allowed':
            errorMessage = "Google sign-in is not enabled for this project.";
            break;
          case 'user-disabled':
            errorMessage = "This user account has been disabled.";
            break;
          case 'user-not-found':
            errorMessage = "No user found for that email.";
            break;
          default:
            errorMessage = e.message ?? "Authentication failed.";
            break;
        }
        Get.snackbar("Sign-in Failed", errorMessage,
            backgroundColor: AppColors.redColor,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM);
        return null;
      }
    } catch (e) {
      print("Google Login Error: ${e.toString()}");
      Get.snackbar("Google Sign-in Error",
          "An unexpected error occurred. Please try again.",
          backgroundColor: AppColors.redColor,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
      return null;
    } finally {
      isGoogleLoading(false);
    }
  }

  void logout() async {
    try {
      await auth.signOut();
      if (await _googleSignIn.isSignedIn()) {
        await _googleSignIn.signOut();
      }
      emailController.clear();
      passwordController.clear();
      Get.offAll(() => SignInScreen());
    } catch (e) {
      print("Logout Error: ${e.toString()}");
      Get.snackbar("Logout Failed", "Failed to log out. Please try again.",
          backgroundColor: AppColors.redColor,
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
