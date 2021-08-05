import 'dart:convert';
import 'dart:typed_data';
import 'package:at_contact/at_contact.dart';
import 'package:at_contacts_flutter/at_contacts_flutter.dart';
import 'package:at_wavi_app/model/notification.dart';
import 'package:at_wavi_app/services/backend_service.dart';
import 'base_model.dart';

class NotificationProvider extends BaseModel {
  NotificationProvider._();
  static NotificationProvider _instance = NotificationProvider._();
  factory NotificationProvider() => _instance;

  List<Notification> notifications = [];
  // ignore: non_constant_identifier_names
  String ADD_NOTIFICATION = 'add_notification';

  /// To get previous notifications
  init() async {
    var _list = await BackendService().atClientInstance.notifyList(
        fromDate: DateTime.now().subtract(Duration(days: 1)).toString());
    _list = _list.replaceAll('data:', '');

    /// TODO: Convert _list to list of Srings
    List<String> values = [];

    await Future.forEach(values, (_value) async {
      var _jsonData = jsonDecode(_value.toString());
      await addNotification(_jsonData['value']);
    });
  }

  addNotification(String decryptedMessage) async {
    try {
      setStatus(ADD_NOTIFICATION, Status.Loading);
      var _notification = Notification.fromJson(jsonDecode(decryptedMessage));

      AtContact contact = await getAtSignDetails(_notification.fromAtsign);
      if (contact != null &&
          contact.tags != null &&
          contact.tags!['image'] != null) {
        List<int> intList = contact.tags!['image'].cast<int>();
        _notification.image = Uint8List.fromList(intList);
      }

      notifications.insert(0, _notification);
      setStatus(ADD_NOTIFICATION, Status.Done);
    } catch (e) {
      print('Error in addNotification $e');
      setStatus(ADD_NOTIFICATION, Status.Error);
    }
  }
}
