import 'package:at_wavi_app/desktop/screens/desktop_login/desktop_passcode_dialog.dart';
import 'package:at_wavi_app/desktop/screens/desktop_notification/desktop_notification_page.dart';
import 'package:flutter/material.dart';

Future<dynamic> showPassCodeDialog(
  BuildContext context, {
  required String atSign,
}) async {
  return showDialog<dynamic>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Center(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Container(
            decoration: BoxDecoration(
                //    border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5),
                color: Colors.white),
            padding: EdgeInsets.all(16.0),
            child: DesktopPassCodeDialog(
              atSign: atSign,
            ),
          ),
        ),
      );
    },
  );
}

Future<dynamic> showNotificationsDialog(
  BuildContext context, {
  required String atSign,
}) async {
  return showDialog<dynamic>(
    context: context,
    barrierDismissible: true,
    barrierColor: Colors.transparent,
    builder: (BuildContext context) {
      return Center(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Container(
            decoration: BoxDecoration(
                //    border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5),
                color: Colors.white),
            padding: EdgeInsets.all(4.0),
            child: DesktopNotificationPage(
              mainContext: context,
              atSign: atSign,
            ),
          ),
        ),
      );
    },
  );
}
