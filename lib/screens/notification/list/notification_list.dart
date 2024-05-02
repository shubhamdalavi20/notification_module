import 'package:flutter/material.dart';

import 'package:notification_module/screens/notification/list/item.dart';
import 'package:notification_module/core/services/storage/database_service.dart';
import 'package:notification_module/core/models/push_notification.dart';

class NotificationList extends StatefulWidget {
  static const route = '/notifications';
  const NotificationList({super.key});

  @override
  State<NotificationList> createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  final DatabaseService _databaseService = DatabaseService();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: Container(
        margin: const EdgeInsets.all(2),
        padding: const EdgeInsets.all(2),
        child: StreamBuilder(
          stream: _databaseService.getNotifications(),
          builder: (context, snapshot) {
            List notifications = snapshot.data?.docs ?? [];
            if (notifications.isEmpty) {
              return const Center(
                child: Text('Notifications is empty'),
              );
            }
            return ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                PushNotification notification = notifications[index].data();
                String notificationID = notifications[index].id;
                return Item(
                  //imageURL: notifications[index].imageURL,
                  notification: notification,
                  notificationID: notificationID,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
