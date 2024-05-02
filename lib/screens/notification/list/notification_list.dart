import 'package:flutter/material.dart';
import 'package:notification_module/core/models/push_notification.dart';

import 'package:notification_module/screens/notification/list/item.dart';

class NotificationList extends StatefulWidget {
  final List<PushNotification> notifications;

  const NotificationList({super.key, required this.notifications});

  @override
  State<NotificationList> createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: Container(
        margin: const EdgeInsets.all(2),
        padding: const EdgeInsets.all(2),
        child: ListView.builder(
          itemCount: widget.notifications.length,
          itemBuilder: (context, index) => Item(
            //imageURL: notifications[index].imageURL,
            title: widget.notifications[index].title.toString(),
            subTitle: widget.notifications[index].body.toString(),
          ),
        ),
      ),
    );
  }
}
