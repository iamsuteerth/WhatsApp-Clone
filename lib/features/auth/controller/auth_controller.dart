import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/features/auth/repository/auth_repository.dart';
import 'package:whatsapp_clone/models/user_model.dart';

final authControllerProvider = Provider((ref) {
  final authRepository = ref.watch(
      authRepositoryProvider); // Because authRepositoryProvider is global
  // ref is Provider.of<AuthRepository>(context
  return AuthController(authRepository: authRepository, ref: ref);
});

final userDataAuthProvider = FutureProvider((ref) {
  final authController = ref.watch(authControllerProvider);
  return authController.getUserData();
});

class AuthController {
  final ProviderRef ref;
  final AuthRepository authRepository;

  AuthController({
    required this.authRepository,
    required this.ref,
  });

  Future<UserModel?> getUserData() async {
    UserModel? usr = await authRepository.getCurrentUserData();
    return usr;
  }

  void signInWithPhone(BuildContext context, String phoneNumber) {
    authRepository.signInWithPhone(context, phoneNumber);
  }

  void verifyOTP(BuildContext context, String verificationId, String userOTP) {
    authRepository.verifyOTP(
      context: context,
      verificationId: verificationId,
      userOTP: userOTP,
    );
  }

  // Here we are not getting a provider ref as we will be using it in a widget which gives widget ref
  void saveUserDataToFirebase(
      BuildContext context, String name, File? profilePic) {
    authRepository.saveUserDataToFirestore(
      context: context,
      ref: ref,
      name: name,
      profilePic: profilePic,
    );
  }
}
