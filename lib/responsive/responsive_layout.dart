import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  // Arguments form main.dart
  final Widget mobileScreenLayout;
  final Widget webScreenLayout;
  const ResponsiveLayout({
    Key? key,
    required this.mobileScreenLayout,
    required this.webScreenLayout,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // Building different layouts for web/mobile
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 750) {
          // WEB LAYOUT
          return webScreenLayout;
        }
        // MOBILE LAYOUT
        return mobileScreenLayout;
      },
    );
  }
}
