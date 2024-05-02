import 'package:cloud_firestore/cloud_firestore.dart';

class PushNotification {
  String title;
  String body;
  bool isOpened;
  Timestamp createdOn;
  Timestamp updatedOn;

  PushNotification({
    required this.title,
    required this.body,
    required this.isOpened,
    required this.createdOn,
    required this.updatedOn,
  });

  PushNotification.fromJson(Map<String, Object?> json)
      : this(
          title: json['title']! as String,
          body: json['body']! as String,
          isOpened: json['isOpened']! as bool,
          createdOn: json['createdOn']! as Timestamp,
          updatedOn: json['updatedOn']! as Timestamp,
        );

  PushNotification copyWith({
    String? title,
    String? body,
    bool? isOpened,
    Timestamp? createdOn,
    Timestamp? updatedOn,
  }) {
    return PushNotification(
        title: title ?? this.title,
        body: body ?? this.body,
        isOpened: isOpened ?? this.isOpened,
        createdOn: createdOn ?? this.createdOn,
        updatedOn: updatedOn ?? this.updatedOn);
  }

  Map<String, Object?> toJson() {
    return {
      'title': title,
      'body': body,
      'isOpened': isOpened,
      'createdOn': createdOn,
      'updatedOn': updatedOn,
    };
  }
}