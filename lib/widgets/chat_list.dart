import 'package:flutter/material.dart';
import 'package:whatsapp_clone/constant_assets/info.dart';
import 'package:whatsapp_clone/widgets/my_message.dart';
import 'package:whatsapp_clone/widgets/sender_message.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: messages.length,
      itemBuilder: (context, index) {
        if (messages[index]['isMe'] == true) {
          // My Message
          return MyMessage(
            message: messages[index]['text'].toString(),
            date: messages[index]['time'].toString(),
          );
        }
        // Sender Message
        return SenderMessage(
          message: messages[index]['text'].toString(),
          date: messages[index]['time'].toString(),
        );
      },
    );
  }
}
