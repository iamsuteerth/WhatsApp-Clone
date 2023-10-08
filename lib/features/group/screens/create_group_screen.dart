import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/common/utils/utils.dart';
import 'package:whatsapp_clone/common/colors.dart';
import 'package:whatsapp_clone/features/group/controller/group_controller.dart';
import 'package:whatsapp_clone/features/group/widgets/select_contact_group.dart';

class CreateGroupScreen extends ConsumerStatefulWidget {
  const CreateGroupScreen({super.key});
  static const String routeName = '/create-group';
  @override
  ConsumerState<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends ConsumerState<CreateGroupScreen> {
  File? image;
  final TextEditingController groupNameController = TextEditingController();

  void pickImage() async {
    image = await pickImageGallery(context);
    setState(() {});
  }

  void createGroup() {
    if (image == null) {
      showSnackBar(
        context: context,
        content: 'Enter an image to continue!',
        bgColor: tabColor,
        textColor: blackThemeColor,
      );
      return;
    }
    if (groupNameController.text.trim().isNotEmpty) {
      ref.read(groupControllerProvider).createGroup(
            context,
            groupNameController.text,
            image!,
            ref.read(selectedGroupContact),
          );
      ref.read(selectedGroupContact.notifier).update((state) => []);
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    super.dispose();
    groupNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Group'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Stack(
              children: [
                image == null
                    ? const CircleAvatar(
                        backgroundImage: NetworkImage(
                          'https://png.pngitem.com/pimgs/s/649-6490124_katie-notopoulos-katienotopoulos-i-write-about-tech-round.png',
                        ),
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
                    onPressed: pickImage,
                    icon: const Icon(
                      Icons.add_a_photo,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                controller: groupNameController,
                decoration: const InputDecoration(
                  hintText: 'Enter group name',
                ),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.all(8),
              child: const Text(
                'Select Contacts',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            const SelectContactsGroup(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createGroup,
        backgroundColor: tabColor,
        child: const Icon(
          Icons.done,
          color: Colors.white,
        ),
      ),
    );
  }
}
