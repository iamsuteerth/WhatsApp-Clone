// ignore_for_file: use_build_context_synchronously
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:whatsapp_clone/common/enums/message_enum.dart';
import 'package:whatsapp_clone/common/providers/message_reply_provider.dart';
import 'package:whatsapp_clone/common/repositories/common_fb_storage_repo.dart';
import 'package:whatsapp_clone/common/utils/utils.dart';
import 'package:whatsapp_clone/models/chat_contact.dart';
import 'package:whatsapp_clone/models/message.dart';
import 'package:whatsapp_clone/models/user_model.dart';

final chatRepoProvider = Provider(
  (ref) => ChatRepository(
    firestore: FirebaseFirestore.instance,
    auth: FirebaseAuth.instance,
  ),
);

class ChatRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  ChatRepository({
    required this.firestore,
    required this.auth,
  });

  Stream<List<Message>> getChatMessages(String receiverUserId) {
    return firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(receiverUserId)
        .collection('messages')
        .orderBy('timeSent')
        .snapshots()
        .map(
      (event) {
        List<Message> messages = [];
        for (var document in event.docs) {
          messages.add(
            Message.fromMap(
              document.data(),
            ),
          );
        }
        return messages;
      },
    );
    // This is not a document snapshot but a query snapshot as
    // snapshots is being called on a collection
  }

  Stream<List<ChatContact>> getChatContacts() {
    // Since we are storing here, we need to retrieve it
    // That is why we are using snapshots
    // Since we will be connection to firestore again in the function, we are using asyncMap
    return firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .snapshots()
        .asyncMap((event) async {
      List<ChatContact> contacts = [];
      for (var document in event.docs) {
        var chatContact = ChatContact.fromMap(document.data());
        var userData = await firestore
            .collection('users')
            .doc(chatContact.contactId)
            .get();
        var user = UserModel.fromMap(userData.data()!);

        contacts.add(
          ChatContact(
            name: user.name,
            profilePic: user.profilePic,
            contactId: chatContact.contactId,
            timeSent: chatContact.timeSent,
            lastMessage: chatContact.lastMessage,
          ),
        );
      }
      return contacts;
    });
  }

  void _saveDataToContactsSubcollection(
    UserModel senderUserData,
    UserModel? receiverUserData,
    String text,
    DateTime timeSent,
    String receiverUserId,
  ) async {
    // users -> reciever user id => chats -> current user id -> set data
    var receiverChatContact = ChatContact(
      name: senderUserData.name,
      profilePic: senderUserData.profilePic,
      contactId: senderUserData.uid,
      timeSent: timeSent,
      lastMessage: text,
    );
    await firestore
        .collection('users')
        .doc(receiverUserId)
        .collection('chats')
        .doc(auth.currentUser!.uid)
        .set(
          receiverChatContact.toMap(),
        );
    // users -> current user id  => chats -> reciever user id -> set data
    var senderChatContact = ChatContact(
      name: receiverUserData!.name,
      profilePic: receiverUserData.profilePic,
      contactId: receiverUserData.uid,
      timeSent: timeSent,
      lastMessage: text,
    );
    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(receiverUserId)
        .set(
          senderChatContact.toMap(),
        );
  }

  void _saveMessageToMessageSubcollection({
    required String receiverUserId,
    required String text,
    required DateTime timeSent,
    required String messageId,
    required String username,
    required String receiverUserName,
    required MessageEnum messageType,
    required MessageReply? messageReply,
    required String senderUserName,
  }) async {
    final message = Message(
      senderId: auth.currentUser!.uid,
      receiverId: receiverUserId,
      text: text,
      type: messageType,
      timeSent: timeSent,
      messageId: messageId,
      isSeen: false,
      repliedMessage: messageReply == null ? '' : messageReply.message,
      repliedTo: messageReply == null
          ? ''
          : messageReply.isMe
              ? senderUserName
              : receiverUserName,
      repliedMessageType:
          messageReply == null ? MessageEnum.TEXT : messageReply.type,
    );

    // users -> sender_id -> receiver_id -> messages -> message_id -> message stored
    // Double storage because both users need their streams updated
    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(receiverUserId)
        .collection('messages')
        .doc(messageId)
        .set(
          message.toMap(),
        );
    // users -> eciever id  -> sender id -> messages -> message id -> store message
    await firestore
        .collection('users')
        .doc(receiverUserId)
        .collection('chats')
        .doc(auth.currentUser!.uid)
        .collection('messages')
        .doc(messageId)
        .set(
          message.toMap(),
        );
  }

  void sendTextMessage({
    required BuildContext context,
    required String text,
    required String receiverUid,
    required UserModel senderUser,
    required MessageReply? repliedMessage,
  }) async {
    try {
      var timeSent = DateTime.now();
      UserModel receiverUserData;
      var messageId = const Uuid().v1();
      var userDataMap =
          await firestore.collection('users').doc(receiverUid).get();

      receiverUserData = UserModel.fromMap(userDataMap.data()!);
      // For the chat list screen (last message)
      _saveDataToContactsSubcollection(
        senderUser,
        receiverUserData,
        text,
        timeSent,
        receiverUid,
      );
      _saveMessageToMessageSubcollection(
        receiverUserId: receiverUid,
        text: text,
        timeSent: timeSent,
        messageType: MessageEnum.TEXT,
        messageId: messageId,
        receiverUserName: receiverUserData.name,
        username: senderUser.name,
        messageReply: repliedMessage,
        senderUserName: senderUser.name,
      );
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }

  void sendFileMessage({
    required BuildContext context,
    required File file,
    required String receiverUserid,
    required UserModel senderUserData,
    required ProviderRef ref,
    required MessageEnum fileType,
    required MessageReply? repliedMessage,
  }) async {
    try {
      var timeSent = DateTime.now();
      var messageId = const Uuid().v1();
      // chats -> filetype -> sender user id -> receiver user id -> message id
      String url = await ref.read(commonFBSRepoProvider).storeFileToFirebase(
          'chat/${fileType.type}/${senderUserData.uid}/$receiverUserid/$messageId',
          file);
      var userDataMap =
          await firestore.collection('users').doc(receiverUserid).get();
      UserModel receiverUserData = UserModel.fromMap(userDataMap.data()!);
      String contactMsg;
      switch (fileType) {
        case MessageEnum.IMAGE:
          contactMsg = '📷 Photo';
          break;
        case MessageEnum.AUDIO:
          contactMsg = '🎤 Audio';
          break;
        case MessageEnum.GIF:
          contactMsg = 'gif';
          break;
        case MessageEnum.VIDEO:
          contactMsg = '📸 Video';
          break;
        default:
          contactMsg = 'Message';
      }
      _saveDataToContactsSubcollection(
        senderUserData,
        receiverUserData,
        contactMsg,
        timeSent,
        receiverUserid,
      );
      _saveMessageToMessageSubcollection(
        receiverUserId: receiverUserid,
        text: url,
        timeSent: timeSent,
        messageId: messageId.toString(),
        username: senderUserData.name,
        receiverUserName: receiverUserData.name,
        messageType: fileType,
        messageReply: repliedMessage,
        senderUserName: senderUserData.name,
      );
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }

  void sendGIFMessage({
    required BuildContext context,
    required String gifUrl,
    required String receiverUserid,
    required UserModel senderUserData,
    required MessageReply? messageReply,
  }) async {
    try {
      var timeSent = DateTime.now();
      var messageId = const Uuid().v1();

      var userDataMap =
          await firestore.collection('users').doc(receiverUserid).get();

      UserModel receiverUserData = UserModel.fromMap(userDataMap.data()!);

      _saveDataToContactsSubcollection(
        senderUserData,
        receiverUserData,
        'gif',
        timeSent,
        receiverUserid,
      );
      _saveMessageToMessageSubcollection(
        receiverUserId: receiverUserid,
        text: gifUrl,
        timeSent: timeSent,
        messageId: messageId.toString(),
        username: senderUserData.name,
        receiverUserName: receiverUserData.name,
        messageType: MessageEnum.GIF,
        messageReply: messageReply,
        senderUserName: senderUserData.name,
      );
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }

  void setChatMessageSeen(
    BuildContext context,
    String receiverUserId,
    String messageId,
  ) async {
    try {
      await firestore
          .collection('users')
          .doc(auth.currentUser!.uid)
          .collection('chats')
          .doc(receiverUserId)
          .collection('messages')
          .doc(messageId)
          .update({'isSeen': true});

      await firestore
          .collection('users')
          .doc(receiverUserId)
          .collection('chats')
          .doc(auth.currentUser!.uid)
          .collection('messages')
          .doc(messageId)
          .update({'isSeen': true});
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }
}
