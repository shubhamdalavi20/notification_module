import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:notification_module/core/models/push_notification.dart';

const String notificationsCollectionRef = "notifications";

class DatabaseService {
  final _firestore = FirebaseFirestore.instance;

  late final CollectionReference _notificationRef;

  DatabaseService() {
    _notificationRef = _firestore.collection(notificationsCollectionRef).withConverter<PushNotification>(
        fromFirestore: (snapshots, _) => PushNotification.fromJson(
              snapshots.data()!,
            ),
        toFirestore: (notification, _) => notification.toJson());
  }

  Stream<QuerySnapshot> getNotifications() {
    return _notificationRef.orderBy("createdOn", descending: true).snapshots();
  }

  void addNotification(PushNotification pn) async {
    _notificationRef.add(pn);
  }

  void updateNotification(String pnId, PushNotification pn) {
    _notificationRef.doc(pnId).update(pn.toJson());
  }

  void deleteNotification(String pnId) {
    _notificationRef.doc(pnId).delete();
  }
}