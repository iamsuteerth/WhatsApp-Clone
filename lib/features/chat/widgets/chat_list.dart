import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:whatsapp_clone/common/enums/message_enum.dart';
import 'package:whatsapp_clone/common/providers/message_reply_provider.dart';
import 'package:whatsapp_clone/common/widgets/loader.dart';
import 'package:whatsapp_clone/features/chat/controller/chat_controller.dart';
import 'package:whatsapp_clone/models/message.dart';
import 'package:whatsapp_clone/features/chat/widgets/my_message.dart';
import 'package:whatsapp_clone/features/chat/widgets/sender_message_card.dart';

class ChatList extends ConsumerStatefulWidget {
  final String receiverUserId;
  const ChatList({required this.receiverUserId, super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatListState();
}

class _ChatListState extends ConsumerState<ChatList> {
  final ScrollController messageController = ScrollController();
  @override
  void dispose() {
    super.dispose();
    messageController.dispose();
  }

  void onMessageSwipe(String message, bool isMe, MessageEnum type) {
    ref.read(messageReplyProvider.notifier).update(
          (state) => MessageReply(
            message: message,
            isMe: isMe,
            type: type,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Message>>(
        stream: ref
            .read(chatControllerProvider)
            .chatMessages(widget.receiverUserId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loader();
          }
          SchedulerBinding.instance.addPostFrameCallback((_) {
            messageController
                .jumpTo(messageController.position.maxScrollExtent);
          });
          return ListView.builder(
            controller: messageController,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final messageData = snapshot.data![index];
              final timeSent = DateFormat.Hm().format(messageData.timeSent);
              if (!messageData.isSeen &&
                  messageData.receiverId ==
                      FirebaseAuth.instance.currentUser!.uid) {
                ref.read(chatControllerProvider).setChatMessageSeen(
                      context,
                      widget.receiverUserId,
                      messageData.messageId,
                    );
              }
              if (messageData.senderId ==
                  FirebaseAuth.instance.currentUser!.uid) {
                return MyMessage(
                  message: messageData.text,
                  date: timeSent,
                  type: messageData.type,
                  repliedText: messageData.repliedMessage,
                  userName: messageData.repliedTo,
                  repliedMessageType: messageData.repliedMessageType,
                  onLeftSwipe: () => onMessageSwipe(
                    messageData.text,
                    true,
                    messageData.type,
                  ),
                  isSeen: messageData.isSeen,
                );
              }
              return SenderMessage(
                message: messageData.text,
                date: timeSent,
                type: messageData.type,
                onRightSwipe: () => onMessageSwipe(
                  messageData.text,
                  false,
                  messageData.type,
                ),
                repliedMessageType: messageData.repliedMessageType,
                repliedText: messageData.repliedMessage,
                userName: messageData.repliedTo,
              );
            },
          );
        });
  }
}
