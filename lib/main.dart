import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/common/widgets/loader.dart';
import 'package:whatsapp_clone/features/auth/controller/auth_controller.dart';
import 'package:whatsapp_clone/features/landing/screens/landing_page.dart';
import 'package:whatsapp_clone/firebase_options.dart';
import 'package:whatsapp_clone/constant_assets/colors.dart';
import 'package:whatsapp_clone/router.dart';
import 'package:whatsapp_clone/screens/mobile_screen_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Binds framework to flutter engine
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WhatsApp',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,
        appBarTheme: const AppBarTheme(
          color: appBarColor,
        ),
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: ref.watch(userDataAuthProvider).when(
        data: (user) {
          return (user == null)
              ? const LandingPageScreen()
              : const MobileScreenLayout();
        },
        error: (error, stackTrace) {
          return ErrorWidget(error.toString());
        },
        loading: () {
          return const Loader();
        },
      ),
    );
  }
}
