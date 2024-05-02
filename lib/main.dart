import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:notification_module/core/screens/home_screen.dart';
import 'package:notification_module/core/screens/phone_auth/sign_in_with_phone.dart';
import 'package:notification_module/core/services/firebase/firebase_options.dart';
import 'package:notification_module/core/services/notifications/notification_service.dart';
import 'package:notification_module/screens/notification/list/notification_list.dart';
import 'package:notification_module/core/theme/theme.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true
  );
  await NotificationService.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkThemeMode,
      navigatorKey: navigatorKey,
      home: (FirebaseAuth.instance.currentUser != null)
          ? const HomeScreen()
          : const SignInWithPhone(),
      routes: {NotificationList.route: (context) => const NotificationList()},
    );
  }
}
