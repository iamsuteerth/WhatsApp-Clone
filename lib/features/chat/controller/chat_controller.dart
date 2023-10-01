import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/common/enums/message_enum.dart';
import 'package:whatsapp_clone/features/auth/controller/auth_controller.dart';
import 'package:whatsapp_clone/features/chat/repositories/chat_repository.dart';
import 'package:whatsapp_clone/models/chat_contact.dart';
import 'package:whatsapp_clone/models/message.dart';

final chatControllerProvider = Provider(
  (ref) {
    final chatRepo = ref.watch(chatRepoProvider);
    return ChatController(
      chatRepository: chatRepo,
      ref: ref,
    );
  },
);

class ChatController {
  final ChatRepository chatRepository;
  final ProviderRef ref;
  ChatController({
    required this.chatRepository,
    required this.ref,
  });

  Stream<List<ChatContact>> chatContacts() {
    return chatRepository.getChatContacts();
  }

  Stream<List<Message>> chatMessages(String receiverUserId) {
    return chatRepository.getChatMessages(receiverUserId);
  }

  void sendTextMessage(
    BuildContext context,
    String text,
    String receiverUid,
  ) {
    ref.read(userDataAuthProvider).whenData(
      (senderUser) {
        chatRepository.sendTextMessage(
          context: context,
          text: text,
          receiverUid: receiverUid,
          senderUser: senderUser!,
        );
      },
    );
  }

  void sendFileMessage(
    BuildContext context,
    File file,
    String receiverUserid,
    MessageEnum fileType,
  ) {
    ref.read(userDataAuthProvider).whenData(
      (senderUser) {
        chatRepository.sendFileMessage(
          context: context,
          file: file,
          receiverUserid: receiverUserid,
          senderUserData: senderUser!,
          ref: ref,
          fileType: fileType,
        );
      },
    );
  }

  void sendGIFMessage(
    BuildContext context,
    String gifUrl,
    String receiverUserid,
  ) {
    // https://giphy.com/gifs/hoppip-art-television-ukyykyDcWZbIQ
    // should be formatted as
    // https://i.giphy.com/media/ukyykyDcWZbIQ/200.gif
    // Can also use lastIndexOf('-') and substring, I chose to do it manually
    String temp = '';
    var i = gifUrl.length - 1;
    while (gifUrl[i] != '-') {
      temp = temp + gifUrl[i];
      i--;
    }
    temp = String.fromCharCodes(temp.codeUnits.reversed);
    String actualUrl = 'https://i.giphy.com/media/$temp/200.gif';
    ref.read(userDataAuthProvider).whenData(
      (senderUser) {
        chatRepository.sendGIFMessage(
          context: context,
          gifUrl: actualUrl,
          receiverUserid: receiverUserid,
          senderUserData: senderUser!,
        );
      },
    );
  }
}
