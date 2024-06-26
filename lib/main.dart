import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:notification_module/core/screens/home_screen.dart';
import 'package:notification_module/core/screens/phone_auth/sign_in_with_phone.dart';
import 'package:notification_module/core/services/firebase/firebase_options.dart';
import 'package:notification_module/core/services/notifications/notification_service.dart';
import 'core/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
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
      home: (FirebaseAuth.instance.currentUser != null) ? const HomeScreen() : const SignInWithPhone(),
    );
  }
}
