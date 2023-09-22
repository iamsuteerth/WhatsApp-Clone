// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsapp_clone/constant_assets/colors.dart';

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

Future<File?> pickImageGallery(BuildContext context) async {
  File? selectedImage;
  try {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 600,
    );
    if (pickedImage != null) {
      selectedImage = File(pickedImage.path);
    }
  } catch (e) {
    showSnackBar(
      context: context,
      content: 'Something went wrong',
      bgColor: tabColor,
      textColor: blackThemeColor,
    );
  }
  return selectedImage;
}
