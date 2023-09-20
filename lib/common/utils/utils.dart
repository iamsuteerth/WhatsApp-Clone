import 'package:flutter/material.dart';

void showSnackBar(
    {required BuildContext context,
    required String content,
    Color? bgColor,
    Color? textColor}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        content,
        style: textColor != null
            ? TextStyle(
                color: textColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              )
            : null,
      ),
      backgroundColor: bgColor ?? bgColor,
    ),
  );
}
