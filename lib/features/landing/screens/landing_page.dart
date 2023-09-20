import 'package:flutter/material.dart';
import 'package:whatsapp_clone/common/widgets/custom_button.dart';
import 'package:whatsapp_clone/constant_assets/colors.dart';
import 'package:whatsapp_clone/features/auth/screens/login_screen.dart';

class LandingPageScreen extends StatelessWidget {
  const LandingPageScreen({super.key});
  void navigateToLoginScreen(BuildContext context) {
    Navigator.pushNamed(context, LoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: screenSize.height / 13),
            const Center(
              child: Text(
                'Welcome to WhatsApp',
                style: TextStyle(
                  fontSize: 31,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: screenSize.height / 9),
            Image.asset(
              'assets/bg.png',
              height: screenSize.height / 2.4, // Tried and tested value
              width: screenSize.height / 2.4, // Tried and tested value
              color: tabColor,
            ),
            SizedBox(height: screenSize.height / 13),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Read our Privacy Policy. Tap "Agree and continue" to accept our Terms of Service.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: greyThemeColor,
                ),
              ),
            ),
            SizedBox(height: screenSize.height / 71.6),
            SizedBox(
              width: screenSize.width * 0.75,
              child: CustomButton(
                text: 'AGREE AND CONTINUE',
                onPressedFunction: () => navigateToLoginScreen(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
