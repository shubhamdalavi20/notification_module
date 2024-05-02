class PushNotification {
  String? title;
  String? body;

  PushNotification({
    required this.title,
    required this.body,
  });

  factory PushNotification.fromJson(Map<String, dynamic> json) => PushNotification(
        title: json["title"],
        body: json["body"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "body": body,
    };
}
