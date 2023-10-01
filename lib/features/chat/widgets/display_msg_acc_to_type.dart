import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/common/enums/message_enum.dart';
import 'package:whatsapp_clone/common/widgets/error.dart';
import 'package:whatsapp_clone/features/chat/widgets/video_player_widget.dart';

class DisplayMessageAccordingToType extends StatelessWidget {
  final String message;
  final MessageEnum type;

  const DisplayMessageAccordingToType(
      {super.key, required this.message, required this.type});
  @override
  Widget build(BuildContext context) {
    bool isPlaying = false;
    final AudioPlayer audioPlayer = AudioPlayer();
    final screenSize = MediaQuery.of(context).size;
    String displayMessage = message;
    if (message.length <= 5) {
      while (displayMessage.length != 6) {
        displayMessage += " ";
      }
    }
    switch (type) {
      case MessageEnum.TEXT:
        return Text(
          displayMessage,
          style: const TextStyle(
            fontSize: 16,
          ),
        );
      case MessageEnum.IMAGE:
        return CachedNetworkImage(imageUrl: message);
      case MessageEnum.VIDEO:
        return VideoPlayerWidget(videoUrl: message);
      case MessageEnum.GIF:
        return CachedNetworkImage(imageUrl: message);
      case MessageEnum.AUDIO:
        // This only rebuilds the widget inside StatefulBuilder
        return StatefulBuilder(
          builder: (context, setState) {
            return IconButton(
              onPressed: () async {
                if (isPlaying) {
                  await audioPlayer.pause();
                  setState(() {
                    isPlaying = false;
                  });
                } else {
                  await audioPlayer.play(
                    UrlSource(message),
                  );
                  setState(() {
                    isPlaying = true;
                  });
                }
              },
              constraints: BoxConstraints(
                minWidth: screenSize.width / 2,
              ),
              icon: Icon(
                (isPlaying) ? Icons.pause_circle : Icons.play_circle,
              ),
            );
          },
        );
      default:
        return const ErrorWidgetCustom();
    }
  }
}
