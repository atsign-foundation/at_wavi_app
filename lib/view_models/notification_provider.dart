import 'package:at_wavi_app/model/notification.dart';
import 'package:at_wavi_app/services/backend_service.dart';
import 'package:at_wavi_app/utils/at_enum.dart';

import 'base_model.dart';

class NotificationProvider extends BaseModel {
  NotificationProvider._();
  static NotificationProvider _instance = NotificationProvider._();
  factory NotificationProvider() => _instance;

  List<Notification> notifications = [];
  String ADD_NOTIFICATION = 'add_notification';

  addNotification(String key, String fromAtSign, String decryptedMessage) {
    setStatus(ADD_NOTIFICATION, Status.Loading);
    var notificationKey = BackendService().formatIncomingKey(key, fromAtSign);
    print('notificationKey $notificationKey');

    var field = valueOf(notificationKey);

    if (field is FieldsEnum) {
      print('$fromAtSign updated their ${field.label} to $decryptedMessage');
      notifications.insert(
          0,
          Notification(fromAtSign,
              '$fromAtSign updated their ${field.label} to $decryptedMessage'));
    }
    setStatus(ADD_NOTIFICATION, Status.Done);
  }
}
