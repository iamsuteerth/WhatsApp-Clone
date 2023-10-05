// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/common/utils/utils.dart';
import 'package:whatsapp_clone/common/widgets/error.dart';
import 'package:whatsapp_clone/constant_assets/colors.dart';
import 'package:whatsapp_clone/features/auth/controller/auth_controller.dart';
import 'package:whatsapp_clone/features/select_contacts/screens/select_contacts_screen.dart';
import 'package:whatsapp_clone/features/chat/widgets/contact_list.dart';
import 'package:whatsapp_clone/features/status/screens/confirm_status_screen.dart';
import 'package:whatsapp_clone/features/status/screens/status_contacts_screen.dart';

class MobileScreenLayout extends ConsumerStatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  ConsumerState<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends ConsumerState<MobileScreenLayout>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  late TabController tabController;

  @override
  // This allows us to know which state app is
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        ref.read(authControllerProvider).setUserState(true);
        break;
      case AppLifecycleState.inactive:
        ref.read(authControllerProvider).setUserState(false);
        break;
      case AppLifecycleState.detached:
        ref.read(authControllerProvider).setUserState(false);
        break;
      case AppLifecycleState.paused:
        ref.read(authControllerProvider).setUserState(false);
        break;
      case AppLifecycleState.hidden:
        ref.read(authControllerProvider).setUserState(false);
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    WidgetsBinding.instance.addObserver(this);
    // I have added this because when you close the app, it re runs, its not "resumed". This When this state is initialized, it will set status to true
    ref.read(authControllerProvider).setUserState(true);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: backgroundColor,
            title: const Text(
              'WhatsApp',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: false,
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.more_vert,
                  color: Colors.grey,
                ),
              ),
            ],
            bottom: TabBar(
              controller: tabController,
              indicatorColor: tabColor,
              indicatorWeight: 4,
              labelColor: tabColor,
              unselectedLabelColor: Colors.grey,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
              tabs: const [
                Tab(
                  text: 'CHATS',
                ),
                Tab(
                  text: 'STATUS',
                ),
                Tab(
                  text: 'CALLS',
                ),
              ],
            ),
          ),
          body: TabBarView(
            controller: tabController,
            children: const [
              ContactsList(),
              StatusContactsScreen(),
              Text('calls'),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              switch (tabController.index) {
                case 0:
                  Navigator.of(context)
                      .pushNamed(SelectContactsScreen.routeName);
                  break;
                case 1:
                  File? pickedImage = await pickImageGallery(context);
                  if (pickedImage != null) {
                    Navigator.of(context).pushNamed(
                        ConfirmStatusScreen.routeName,
                        arguments: pickedImage);
                  }
                  break;
                default:
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ErrorWidgetCustom(),
                    ),
                  );
              }
            },
            backgroundColor: tabColor,
            child: const Icon(
              Icons.comment,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
