import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventhub/constant/colors/colors.dart';
import 'package:eventhub/models/events_detail_model.dart';
import 'package:eventhub/views/bottom_naivgation_bar_screen.dart';
import 'package:eventhub/views/sign_in_screen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  var isRegisterLoading = false.obs;
  var isLoginLoading = false.obs;
  var isGoogleLoading = false.obs;
  final forgotPasswordEmailController = TextEditingController();
  final isResetLoading = false.obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  // Initialize GoogleSignIn with minimal scopes
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

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
        Get.snackbar(
          "Password Error",
          "Passwords do not match",
          backgroundColor: AppColors.redColor,
          snackPosition: SnackPosition.BOTTOM,
          titleText: Text(
            "Password Mismatch",
            style: GoogleFonts.montserrat(color: AppColors.whiteColor),
          ),
          messageText: Text(
            "Please ensure both passwords are the same.",
            style: GoogleFonts.montserrat(color: AppColors.whiteColor),
          ),
        );
        return;
      }
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

        Get.snackbar(
          "Success",
          "Account created successfully",
          backgroundColor: Colors.green,
          snackPosition: SnackPosition.BOTTOM,
        );

        Get.off(() => BottomNavigationBarScreen());
      } else {
        Get.snackbar(
          "Registration Failed",
          "User could not be created",
          backgroundColor: AppColors.redColor,
          snackPosition: SnackPosition.BOTTOM,
          titleText: Text(
            "Account Creation Failed",
            style: GoogleFonts.montserrat(color: AppColors.whiteColor),
          ),
          messageText: Text(
            "There was an issue with creating your account. Please try again.",
            style: GoogleFonts.montserrat(color: AppColors.whiteColor),
          ),
        );
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

      Get.snackbar(
        "Registration Failed",
        errorMessage,
        backgroundColor: AppColors.redColor,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isRegisterLoading(false);
    }
  }

  Future<void> addEventToUser(String uid, Event event) async {
    try {
      DocumentReference eventDocRef = FirebaseFirestore.instance
          .collection('events')
          .doc(uid);
      Map<String, dynamic> eventMap = {
        'events_title': event.eventsTitle,
        'imgUrl': event.imgUrl,
        'events_date': event.eventsDate,
        'events_day': event.eventsDay,
        'events_name': event.eventsName,
        'address': event.address,
        'ticket_amont': event.ticketAmont,
        'about_events': event.aboutEvents,
      };

      DocumentSnapshot docSnapshot = await eventDocRef.get();
      if (docSnapshot.exists) {
        Map<String, dynamic> docData =
            docSnapshot.data() as Map<String, dynamic>;

        if (docData.containsKey('events_data')) {
          await eventDocRef.update({
            'events_data': FieldValue.arrayUnion([eventMap]),
          });
        } else {
          await eventDocRef.update({
            'events_data': [eventMap],
          });
        }
      } else {
        await eventDocRef.set({
          'Uid': uid,
          'createdAt': FieldValue.serverTimestamp(),
          'events_data': [eventMap],
        });
      }

      print("Event added successfully!");
    } catch (e) {
      print("Error adding event: $e");
      rethrow;
    }
  }

  // login
  void login() async {
    try {
      isLoginLoading(true);
      await auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
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

      Get.snackbar(
        "Login Failed",
        errorMessage,
        backgroundColor: AppColors.redColor,
        snackPosition: SnackPosition.BOTTOM,
        titleText: Text(
          "Login Failed",
          style: GoogleFonts.montserrat(color: AppColors.whiteColor),
        ),
        messageText: Text(
          errorMessage,
          style: GoogleFonts.montserrat(color: AppColors.whiteColor),
        ),
      );
    } finally {
      isLoginLoading(false);
    }
  }

  Future<void> sendPasswordResetEmail() async {
    try {
      isResetLoading.value = true;
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: forgotPasswordEmailController.text.trim(),
      );
      Get.snackbar(
        'Success',
        'Password reset link sent to your email',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Get.back(); // Go back to sign in screen
    } on FirebaseAuthException catch (e) {
      String message = 'An error occurred';
      if (e.code == 'user-not-found') {
        message = 'No user found with this email';
      } else if (e.code == 'invalid-email') {
        message = 'Invalid email format';
      }
      Get.snackbar(
        'Error',
        message,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to send password reset email',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isResetLoading.value = false;
    }
  }

  Future<UserCredential?> loginWithGoogle() async {
    try {
      isGoogleLoading(true);

      print("Starting Google Sign-In process...");
      await _googleSignIn.signOut();

      _googleSignIn = GoogleSignIn(
        scopes: ['email'],
        clientId: 'YOUR_WEB_CLIENT_ID_HERE.apps.googleusercontent.com',
      );
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        print("Sign-in cancelled by user");
        Get.snackbar(
          "Sign-in Cancelled",
          "Google sign-in was cancelled",
          backgroundColor: Colors.orange,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
        return null;
      }

      print("User signed in with Google: ${googleUser.email}");
      print("Display Name: ${googleUser.displayName}");
      print(
        "Photo URL: ${googleUser.photoUrl != null ? 'Available' : 'Not available'}",
      );
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      print("Access token available: ${googleAuth.accessToken != null}");
      print("ID token available: ${googleAuth.idToken != null}");
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      try {
        print("Signing in to Firebase with Google credential");
        final userCredential = await FirebaseAuth.instance.signInWithCredential(
          credential,
        );

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
                "provider": "google",
              });
        }
        Get.offAll(() => BottomNavigationBarScreen());
        return userCredential;
      } on FirebaseAuthException catch (e) {
        print("Firebase Auth Exception: ${e.code} - ${e.message}");

        String errorMessage;
        switch (e.code) {
          case 'account-exists-with-different-credential':
            errorMessage =
                "An account already exists with the same email address but different sign-in credentials.";
            break;
          case 'invalid-credential':
            errorMessage =
                "The credential is invalid for this Firebase project. Check your Firebase console configuration.";
            break;
          case 'operation-not-allowed':
            errorMessage =
                "Google sign-in is not enabled for this Firebase project.";
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

        Get.snackbar(
          "Sign-in Failed",
          errorMessage,
          backgroundColor: AppColors.redColor,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
        return null;
      }
    } catch (e) {
      print("Google Sign-In Error: ${e.toString()}");
      Get.snackbar(
        "Sign-in Error",
        "An unexpected error occurred: ${e.toString()}",
        backgroundColor: AppColors.redColor,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return null;
    } finally {
      isGoogleLoading(false);
    }
  }

  // Logout
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
      Get.snackbar(
        "Logout Failed",
        "Failed to log out. Please try again.",
        backgroundColor: AppColors.redColor,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    confirmpasswordController.dispose();
    username.dispose();
    forgotPasswordEmailController.dispose();
    super.onClose();
  }
}
