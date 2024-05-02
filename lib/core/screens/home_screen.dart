import 'package:badges/badges.dart' as badges;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:notification_module/core/screens/phone_auth/sign_in_with_phone.dart';
import 'package:notification_module/core/services/storage/database_service.dart';
import 'package:notification_module/screens/notification/list/notification_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseService databaseService = DatabaseService();
  
  void logOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(context,
        CupertinoPageRoute(builder: (context) => const SignInWithPhone()));
  }

  void openNotificationList() {
    Navigator.push(context,
        CupertinoPageRoute(builder: (context) => const NotificationList()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          badges.Badge(
            badgeContent: Text(databaseService.getNotificationsCount().toString()), 
            child: IconButton(
              onPressed: () {
                openNotificationList();
              },
              icon: const Icon(Icons.notifications),
            ),
          ),
          IconButton(
            onPressed: () {
              logOut();
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: const Center(
        child: Text('Home Page!'),
      ),
    );
  }
}
