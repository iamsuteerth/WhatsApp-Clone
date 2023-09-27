// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/common/repositories/common_fb_storage_repo.dart';
import 'package:whatsapp_clone/common/utils/utils.dart';
import 'package:whatsapp_clone/constant_assets/colors.dart';
import 'package:whatsapp_clone/features/auth/screens/otp_screen.dart';
import 'package:whatsapp_clone/features/auth/screens/user_info.dart';
import 'package:whatsapp_clone/models/user_model.dart';
import 'package:whatsapp_clone/screens/mobile_screen_layout.dart';

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

  AuthRepository({
    required this.auth,
    required this.firestore,
  });

  Future<UserModel?> getCurrentUserData() async {
    var userData =
        await firestore.collection('users').doc(auth.currentUser?.uid).get();
    UserModel? usr;
    if (userData.data() != null) {
      usr = UserModel.fromMap(userData.data()!);
    }
    return usr;
  }

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
          Navigator.of(context).pushNamedAndRemoveUntil(
            OTPSCreen.routeName,
            arguments: verificationId,
            (route) => false,
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

  // Ref is needed to call another provider
  void saveUserDataToFirestore({
    required BuildContext context,
    required ProviderRef ref,
    required String name,
    required File? profilePic,
  }) async {
    try {
      // We come here only if
      String uid = auth.currentUser!.uid;
      // ignore: unused_local_variable
      String photoUrl =
          'https://drive.google.com/file/d/1Zf7-yzpRc2fMgppXEfhNhe82PEwFsmrc/view?usp=sharing';
      if (profilePic != null) {
        photoUrl = await ref.read(commonFBSRepoProvider).storeFileToFirebase(
              'profilePic/$uid',
              profilePic,
            );
        // Filename is UID
        var user = UserModel(
          name: name,
          uid: uid,
          profilePic: photoUrl,
          isOnline: true,
          phoneNumber: auth.currentUser!.phoneNumber!,
          groupId: [],
        );
        await firestore.collection('users').doc(uid).set(user.toMap());

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const MobileScreenLayout(),
          ),
          (route) => false,
        );
      }
    } catch (e) {
      showSnackBar(
        context: context,
        content: e.toString(),
        bgColor: tabColor,
        textColor: blackThemeColor,
      );
    }
  }

  Stream<UserModel> userDataById(String uid) {
    // We have to snapshot of user data
    // We are mapping through it and make the event be converted into userModel
    return firestore.collection('users').doc(uid).snapshots().map(
          (event) => UserModel.fromMap(event.data()!),
        );
  }
}
