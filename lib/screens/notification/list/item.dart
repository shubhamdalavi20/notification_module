import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notification_module/core/models/push_notification.dart';
import 'package:notification_module/core/services/storage/database_service.dart';

import 'package:notification_module/screens/notification/list/details/details.dart';

class Item extends StatefulWidget {
  final PushNotification notification;
  final String notificationID;
  const Item({
    super.key,
    required this.notification,
    required this.notificationID,
  });

  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> {
  final DatabaseService _databaseService = DatabaseService();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(10),
      title: Text(
        widget.notification.title,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            fontWeight: widget.notification.isOpened
                ? FontWeight.normal
                : FontWeight.bold),
      ),
      subtitle: Text(
        widget.notification.body,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: const Icon(Icons.navigate_next),
      onTap: () {
        if (!widget.notification.isOpened) {
          PushNotification updatedPushNotification = widget.notification
              .copyWith(isOpened: true, updatedOn: Timestamp.now());
          _databaseService.updateNotification(
              widget.notificationID, updatedPushNotification);
        }
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Details(
                title: widget.notification.title,
                subTitle: widget.notification.body),
          ),
        );
      },
    );
  }
}
