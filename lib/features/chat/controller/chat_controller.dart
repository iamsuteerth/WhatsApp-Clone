import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  void sendTextMessage(BuildContext context, String text, String receiverUid) {
    ref.read(userDataAuthProvider).whenData(
          (senderUser) => chatRepository.sendTextMessage(
            context: context,
            text: text,
            receiverUid: receiverUid,
            senderUser: senderUser!,
          ),
        );
  }
}
