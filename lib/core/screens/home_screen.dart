import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:notification_module/core/models/push_notification.dart';
import 'package:notification_module/screens/notification/list/notification_list.dart';
import 'package:notification_module/core/screens/phone_auth/sign_in_with_phone.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  List<PushNotification> notifications = List.empty(growable: true);

  late SharedPreferences sp;
  void getSharedPreferences() async {
    sp = await SharedPreferences.getInstance();
  }

  void saveIntoSharedPreferences () {
    List<String> notificationList = notifications.map((notification) => jsonEncode(notification.toJson())).toList();
    sp.setStringList('notificationList', notificationList);
  }

  void retriveFromSharedPreferences () {
    List<String>? notificationList = sp.getStringList('notificationList');
    if (notificationList != null) {
      notifications = notificationList.map((notification) => PushNotification.fromJson(json.decode(notification))).toList();
    }
    setState(() {
      
    });
  }
 
  void logOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(context,
        CupertinoPageRoute(builder: (context) => const SignInWithPhone()));
  }

  void getInitialMessage() async {
    RemoteMessage? message =
        await FirebaseMessaging.instance.getInitialMessage();

    if (message != null) {
      retriveFromSharedPreferences();
      notifications.add(
        PushNotification(
          title: message.notification!.title,
          body: message.notification!.body,
        ),
      );
      saveIntoSharedPreferences();

      if (message.data["page"] == "notification") {
        Navigator.push(context,
            CupertinoPageRoute(builder: (context) => NotificationList(notifications: notifications)));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Invalid Page!"),
          duration: Duration(seconds: 5),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  @override
  void initState() {
    getSharedPreferences();
    getInitialMessage();

    FirebaseMessaging.onMessage.listen((message) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("App was opened by a onMessage"),
        duration: Duration(seconds: 10),
        backgroundColor: Colors.green,
      ));
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("App was opened by a onMessageOpenedApp"),
        duration: Duration(seconds: 10),
        backgroundColor: Colors.green,
      ));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
            onPressed: () {
              logOut();
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(hintText: "Name"),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(hintText: "Email Address"),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: ageController,
                decoration: const InputDecoration(hintText: "Age"),
              ),
              const SizedBox(
                height: 10,
              ),
              
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
