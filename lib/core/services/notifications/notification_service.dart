import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:notification_module/core/models/push_notification.dart';

import 'package:notification_module/core/services/storage/database_service.dart';
import 'package:notification_module/main.dart';
import 'package:notification_module/screens/notification/list/notification_list.dart';

void addNotificationInFirebase(RemoteNotification? message) {
  final DatabaseService databaseService = DatabaseService();
  PushNotification notification = PushNotification(
      title: message!.title.toString(),
      body: message.body.toString(),
      isOpened: false,
      createdOn: Timestamp.now(),
      updatedOn: Timestamp.now());
  databaseService.addNotification(notification);
}

Future<void> backgroundMessageHandler(RemoteMessage message) async {
  addNotificationInFirebase(message.notification);
  
  log("App was opened by backgroundMessageHandler");
  if (message.data["page"] == "notification") {
    navigatorKey.currentState?.pushNamed(NotificationList.route);
  }
}

class NotificationService {
  static final _firebaseMessaging = FirebaseMessaging.instance;

  static void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    addNotificationInFirebase(message.notification);
    
    log("App was opened by getInitialMessage");
    if (message.data["page"] == "notification") {
      navigatorKey.currentState?.pushNamed(NotificationList.route);
    }
  }

  static Future initPushNotification() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) return;
      addNotificationInFirebase(message.notification);
    });
  }

  static Future<void> initialize() async {
    NotificationSettings settings =
        await _firebaseMessaging.requestPermission();
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      String? token = await _firebaseMessaging.getToken();
      if (token != null) {
        log(token);
      }
      initPushNotification();
      log("Firebase notifications initialized!");
    }
  }
}
