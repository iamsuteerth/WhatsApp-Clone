// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:enough_giphy_flutter/enough_giphy_flutter.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsapp_clone/common/colors.dart';

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

Future<File?> pickVideoGallery(BuildContext context) async {
  File? video;
  try {
    final imagePicker = ImagePicker();
    final pcikedVideo = await imagePicker.pickVideo(
      source: ImageSource.gallery,
    );
    if (pcikedVideo != null) {
      video = File(pcikedVideo.path);
    }
  } catch (e) {
    showSnackBar(
      context: context,
      content: 'Something went wrong',
      bgColor: tabColor,
      textColor: blackThemeColor,
    );
  }
  return video;
}

Future<GiphyGif?> pickGif(BuildContext context) async {
  GiphyGif? gif;
  try {
    gif = await Giphy.getGif(
      context: context,
      apiKey: 'YOUR_API_KEY',
    );
  } catch (e) {
    showSnackBar(context: context, content: e.toString());
  }
  return gif;
}
