// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/common/utils/utils.dart';
import 'package:whatsapp_clone/common/colors.dart';
import 'package:whatsapp_clone/models/user_model.dart';
import 'package:whatsapp_clone/features/chat/screens/mobile_chat_screen.dart';

final selectContactsRepoProvider = Provider(
  (ref) => SelectContactRepository(
    firestore: FirebaseFirestore.instance,
  ),
);

class SelectContactRepository {
  final FirebaseFirestore firestore;

  SelectContactRepository({required this.firestore});

  Future<List<Contact>> getContacts() async {
    List<Contact> contacts = [];
    try {
      if (await FlutterContacts.requestPermission()) {
        contacts = await FlutterContacts.getContacts(
          withProperties: true,
        );
        // withProperties will give us the detauks
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return contacts;
  }

  void selectContact(Contact selectedContact, BuildContext context) async {
    try {
      var userCollection = await firestore.collection('users').get();
      bool isFound = false;
      for (var document in userCollection.docs) {
        var userData = UserModel.fromMap(document.data());
        String selectedPhoneNumber =
            selectedContact.phones[0].number.replaceAll(' ', '');
        if (selectedPhoneNumber == userData.phoneNumber) {
          isFound = true;
          Navigator.pushNamed(
            context,
            MobileChatScreen.routeName,
            arguments: {
              'name': userData.name,
              'uid': userData.uid,
            },
          );
        }
      }
      if (!isFound) {
        showSnackBar(
          context: context,
          content: 'This number doesn\'t exist on this app',
          bgColor: tabColor,
          textColor: blackThemeColor,
        );
      }
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }
}
