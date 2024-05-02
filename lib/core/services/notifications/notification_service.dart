import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';


Future<void> backgroundMessageHandler(RemoteMessage message) async {
  if (message.data["page"] == "notifications") {
    log("App was opened by ${message.data["page"]} backgroundMessageHandler");
  }
}

class NotificationService {
  static Future<void> initialize() async {
    NotificationSettings settings =
        await FirebaseMessaging.instance.requestPermission();
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      String? token = await FirebaseMessaging.instance.getToken();
      if (token != null) {
        log(token);
      }
      log("Firebase notifications initialized!");
      FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);
    }
  }
}
