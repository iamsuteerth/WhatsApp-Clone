import 'package:flutter/material.dart';
import 'package:whatsapp_clone/common/widgets/loader.dart';
import 'package:whatsapp_clone/models/status.dart';
import 'package:story_view/story_view.dart';

class StatusScreen extends StatefulWidget {
  static const String routeName = '/status-screen';
  final Status status;
  const StatusScreen({super.key, required this.status});

  @override
  State<StatefulWidget> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  List<StoryItem> storyItems = [];
  StoryController controller = StoryController();
  @override
  void initState() {
    super.initState();
    initStoryPageItems();
  }

  void initStoryPageItems() {
    for (var i = 0; i < widget.status.photoUrl.length; i++) {
      storyItems.add(
        StoryItem.pageImage(
            url: widget.status.photoUrl[i], controller: controller),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: storyItems.isEmpty
          ? const Loader()
          : StoryView(
              storyItems: storyItems,
              controller: controller,
              onVerticalSwipeComplete: (direction) {
                if (direction == Direction.down) {
                  Navigator.of(context).pop();
                }
              },
            ),
    );
  }
}
