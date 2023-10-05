import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/common/enums/message_enum.dart';

class MessageReply {
  final String message;
  final bool isMe;
  final MessageEnum type;

  MessageReply({required this.message, required this.isMe, required this.type});
}

final messageReplyProvider = StateProvider<MessageReply?>((ref) => null);
