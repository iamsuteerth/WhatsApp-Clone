// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/common/utils/utils.dart';
import 'package:whatsapp_clone/constant_assets/colors.dart';
import 'package:whatsapp_clone/features/auth/screens/otp_screen.dart';
import 'package:whatsapp_clone/features/auth/screens/user_info.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
  ),
);

// Now this class is independent as it accepts it from constructor
// We can interact with other providers using this ref
class AuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  const AuthRepository({required this.auth, required this.firestore});
  void signInWithPhone(BuildContext context, String phoneNumber) async {
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (phoneAuthCredential) async {
          await auth.signInWithCredential(phoneAuthCredential);
        },
        verificationFailed: (error) {
          throw Exception(error.message);
        },
        codeSent: (verificationId, forceResendingToken) {
          Navigator.of(context).pushNamed(
            OTPSCreen.routeName,
            arguments: verificationId,
          );
        },
        codeAutoRetrievalTimeout:
            (verificationId) {}, // Auto Resolution is timed out
      );
    } on FirebaseAuthException catch (e) {
      showSnackBar(context: context, content: e.message!);
    }
  }

  void verifyOTP({
    required BuildContext context,
    required String verificationId,
    required String userOTP,
  }) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: userOTP,
      );
      await auth.signInWithCredential(credential);
      // This doesn't allow us to go back to the OTP screen
      Navigator.pushNamedAndRemoveUntil(
        context,
        UserInfoScreen.routeName,
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      showSnackBar(
        context: context,
        content: e.message!,
        bgColor: tabColor,
        textColor: blackThemeColor,
      );
    }
  }
}
