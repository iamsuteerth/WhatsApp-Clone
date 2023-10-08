import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/common/widgets/loader.dart';
import 'package:whatsapp_clone/common/colors.dart';
import 'package:whatsapp_clone/features/status/controller/status_controller.dart';
import 'package:whatsapp_clone/features/status/screens/status_screen.dart';
import 'package:whatsapp_clone/models/status.dart';

class StatusContactsScreen extends ConsumerWidget {
  const StatusContactsScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<List<Status>>(
      future: ref.read(statusControllerProvider).getStatus(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loader();
        }
        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            var statusData = snapshot.data![index];
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        StatusScreen.routeName,
                        arguments: statusData,
                      );
                    },
                    child: ListTile(
                      title: Text(
                        statusData.username,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      leading: CircleAvatar(
                        backgroundImage: CachedNetworkImageProvider(
                          statusData.profilePic,
                        ),
                        radius: 25,
                      ),
                    ),
                  ),
                ),
                const Divider(color: dividerColor, indent: 85),
              ],
            );
          },
        );
      },
    );
  }
}
