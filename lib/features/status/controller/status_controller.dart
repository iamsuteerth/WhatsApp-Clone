import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/features/auth/controller/auth_controller.dart';
import 'package:whatsapp_clone/features/status/repostiories/status_repository.dart';
import 'package:whatsapp_clone/models/status.dart';

final statusControllerProvider = Provider((ref) {
  final statusRepository = ref.read(statusRepositoryProvider);
  return StatusController(statusRepository: statusRepository, ref: ref);
});

class StatusController {
  final StatusRepository statusRepository;
  final ProviderRef ref;

  StatusController({
    required this.statusRepository,
    required this.ref,
  });
  void addStatus(File file, BuildContext context) {
    // Since we need user data
    ref.watch(userDataAuthProvider).whenData(
          (value) => statusRepository.uploadStatus(
            username: value!.name,
            profilePic: value.profilePic,
            phoneNumber: value.phoneNumber,
            statusImage: file,
            context: context,
          ),
        );
  }

  Future<List<Status>> getStatus(BuildContext context) async {
    List<Status> statuses = await statusRepository.getStatus(context);
    return statuses;
  }
}
