import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/common/utils/utils.dart';
import 'package:whatsapp_clone/constant_assets/colors.dart';
import 'package:whatsapp_clone/features/auth/controller/auth_controller.dart';

class UserInfoScreen extends ConsumerStatefulWidget {
  static const String routeName = '/user_info';
  const UserInfoScreen({super.key});

  @override
  ConsumerState<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends ConsumerState<UserInfoScreen> {
  final TextEditingController nameController = TextEditingController();
  File? image;
  var isLoading = false;
  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
  }

  void selectImage() async {
    image = await pickImageGallery(context);
    setState(() {});
  }

  void storeUserData() async {
    String name = nameController.text.trim();
    setState(() {
      isLoading = true;
    });
    if (name.isNotEmpty) {
      if (image == null) {
        showSnackBar(
          context: context,
          content: 'Please select an image',
          bgColor: tabColor,
          textColor: blackThemeColor,
        );
        return;
      }
      ref.read(authControllerProvider).saveUserDataToFirebase(
            context,
            name,
            image,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 12,
              ),
              Stack(
                children: [
                  image == null
                      ? const CircleAvatar(
                          backgroundColor: greyThemeColor,
                          radius: 64,
                        )
                      : CircleAvatar(
                          backgroundColor: greyThemeColor,
                          backgroundImage: FileImage(image!),
                          radius: 64,
                        ),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(
                        Icons.add_a_photo,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: screenSize.width * 0.85,
                    padding: const EdgeInsets.all(20),
                    child: TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        hintText: 'Enter your name',
                      ),
                    ),
                  ),
                  isLoading
                      ? const CircularProgressIndicator(
                          color: tabColor,
                        )
                      : IconButton(
                          onPressed: storeUserData,
                          icon: const Icon(Icons.done),
                        ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
