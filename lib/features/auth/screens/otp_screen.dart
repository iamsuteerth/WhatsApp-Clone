import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/constant_assets/colors.dart';
import 'package:whatsapp_clone/features/auth/controller/auth_controller.dart';

class OTPSCreen extends ConsumerWidget {
  static const String routeName = '/otp-screen';
  final String verificationId;
  const OTPSCreen({super.key, required this.verificationId});
  void verifyOTP(BuildContext context, WidgetRef ref, String userOTP) {
    ref.read(authControllerProvider).verifyOTP(
          context,
          verificationId,
          userOTP,
        );
  }

  @override
  // WidgetRef commincates widget to providers
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        title: const Text('Verifying your number'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text('We have sent an SMS with a code.'),
            SizedBox(
              width: screenSize.width * 0.5,
              child: TextField(
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  hintText: '_ _ _ _ _ _',
                  hintStyle: TextStyle(
                    fontSize: 30,
                  ),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  if (value.length == 6) {
                    verifyOTP(context, ref, value.trim());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
