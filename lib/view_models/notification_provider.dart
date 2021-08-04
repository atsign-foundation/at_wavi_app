import 'dart:convert';
import 'package:at_wavi_app/model/notification.dart';
import 'base_model.dart';

class NotificationProvider extends BaseModel {
  NotificationProvider._();
  static NotificationProvider _instance = NotificationProvider._();
  factory NotificationProvider() => _instance;

  List<Notification> notifications = [];
  // ignore: non_constant_identifier_names
  String ADD_NOTIFICATION = 'add_notification';

  addNotification(String decryptedMessage) {
    try {
      setStatus(ADD_NOTIFICATION, Status.Loading);
      notifications.insert(
          0, Notification.fromJson(jsonDecode(decryptedMessage)));
      setStatus(ADD_NOTIFICATION, Status.Done);
    } catch (e) {
      print('Error in addNotification $e');
      setStatus(ADD_NOTIFICATION, Status.Error);
    }
  }
}
