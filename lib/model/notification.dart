import 'dart:convert';

class Notification {
  String fromAtsign, message;
  DateTime dateTime;
  Notification(this.fromAtsign, this.message, this.dateTime);

  Notification.fromJson(Map<String, dynamic> json)
      : fromAtsign = json['fromAtsign'],
        message = json['message'],
        dateTime = DateTime.parse(json['dateTime']).toLocal();

  toJson() {
    return json.encode({
      'fromAtsign': fromAtsign.toString(),
      'message': message.toString(),
      'dateTime': dateTime.toUtc().toString(),
    });
  }
}
