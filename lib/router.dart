import 'package:flutter/material.dart';
import 'package:whatsapp_clone/common/widgets/error.dart';
import 'package:whatsapp_clone/features/auth/screens/login_screen.dart';
import 'package:whatsapp_clone/features/auth/screens/otp_screen.dart';
import 'package:whatsapp_clone/features/auth/screens/user_info.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case LoginScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      );
    case OTPSCreen.routeName:
      final verificationId = routeSettings.arguments as String;
      return MaterialPageRoute(
        builder: (context) => OTPSCreen(verificationId: verificationId),
      );
    case UserInfoScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const UserInfoScreen(),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: ErrorWidgetCustom(error: 'This page does not exist'),
        ),
      );
  }
}
