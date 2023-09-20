import 'package:flutter/material.dart';
import 'package:whatsapp_clone/constant_assets/colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressedFunction;
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressedFunction,
  });
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressedFunction,
      style: ElevatedButton.styleFrom(
        backgroundColor: tabColor,
        minimumSize: const Size(
          double.infinity,
          50,
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: blackThemeColor,
        ),
      ),
    );
  }
}
