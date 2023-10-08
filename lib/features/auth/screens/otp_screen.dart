import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/common/widgets/custom_button.dart';
import 'package:whatsapp_clone/common/colors.dart';
import 'package:whatsapp_clone/features/auth/controller/auth_controller.dart';
import 'package:whatsapp_clone/features/auth/screens/login_screen.dart';

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
        title: const Center(
          child: Text('Verifying your number'),
        ),
      ),
      body: SizedBox(
        height: screenSize.height * 0.95,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
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
                SizedBox(
                  height: screenSize.height * 0.6,
                ),
                SizedBox(
                  width: screenSize.width * 0.5,
                  child: CustomButton(
                    text: 'CHANGE NUMBER',
                    onPressedFunction: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        LoginScreen.routeName,
                        (route) => false,
                        arguments: null,
                      );
                    },
                    loading: false,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
