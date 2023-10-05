import 'package:flutter/material.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:whatsapp_clone/common/enums/message_enum.dart';
import 'package:whatsapp_clone/constant_assets/colors.dart';
import 'package:whatsapp_clone/features/chat/widgets/display_msg_acc_to_type.dart';

class MyMessage extends StatelessWidget {
  final String message;
  final String date;
  final MessageEnum type;
  final VoidCallback onLeftSwipe;
  final String repliedText;
  final String userName;
  final MessageEnum repliedMessageType;
  final bool isSeen;
  const MyMessage({
    super.key,
    required this.message,
    required this.date,
    required this.type,
    required this.onLeftSwipe,
    required this.repliedText,
    required this.userName,
    required this.repliedMessageType,
    required this.isSeen,
  });
  @override
  Widget build(BuildContext context) {
    final isReplying = repliedText.isNotEmpty;
    return SwipeTo(
      onLeftSwipe: onLeftSwipe,
      child: Align(
        alignment: Alignment.centerRight,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width - 45,
          ),
          child: Card(
            elevation: 1,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            color: messageColor,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            child: Stack(
              children: [
                Padding(
                  padding: type == MessageEnum.TEXT
                      ? const EdgeInsets.only(
                          left: 8,
                          right: 33,
                          top: 5,
                          bottom: 22,
                        )
                      : const EdgeInsets.only(
                          left: 5,
                          top: 5,
                          right: 5,
                          bottom: 25,
                        ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (isReplying) ...[
                        Text(
                          userName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: backgroundColor.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: DisplayMessageAccordingToType(
                            message: repliedText,
                            type: repliedMessageType,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                      ],
                      DisplayMessageAccordingToType(
                        message: message,
                        type: type,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 3.5,
                  right: 2.5,
                  child: Row(
                    children: [
                      Text(
                        date,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.white60,
                        ),
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Icon(
                        Icons.done_all,
                        size: 20,
                        color: !isSeen ? Colors.white60 : Colors.blue,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
