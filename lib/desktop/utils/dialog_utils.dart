import 'package:at_wavi_app/desktop/screens/desktop_basic_detail/desktop_reorder_basic_detail/desktop_reorder_basic_detail_page.dart';
import 'package:at_wavi_app/desktop/screens/desktop_login/desktop_passcode_dialog.dart';
import 'package:at_wavi_app/desktop/screens/desktop_notification/desktop_notification_page.dart';
import 'package:at_wavi_app/desktop/utils/shared_preferences_utils.dart';
import 'package:at_wavi_app/desktop/utils/strings.dart';
import 'package:at_wavi_app/utils/at_enum.dart';
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

Future showReOderTabsPopUp(
    BuildContext context, Function(List<String>) updateFields) async {
  var currentScreen =
      await getStringFromSharedPreferences(key: Strings.desktop_current_tab);
  AtCategory atCategory;
  if(currentScreen == AtCategory.FEATURED.name){
    atCategory = AtCategory.SOCIAL;
  } else {
    atCategory = AtCategory.values.firstWhere(
          (element) {
        return element.name == currentScreen;
      },
      orElse: () => AtCategory.OTHERS,
    );
  }

  final results = await showDialog<List<String>>(
    context: context,
    builder: (BuildContext context) => Dialog(
      backgroundColor: Colors.transparent,
      child: DesktopReorderBasicDetailPage(
        atCategory: atCategory,
      ),
    ),
  );
  if (results != null) {
    List<String> fields = results;
    updateFields(fields);
  }
}

Future showReOderFieldsPopUp(BuildContext context, AtCategory atCategory,
    Function() updateFields) async {
  final results = await showDialog<List<String>>(
    context: context,
    builder: (BuildContext context) => Dialog(
      backgroundColor: Colors.transparent,
      child: DesktopReorderBasicDetailPage(
        atCategory: atCategory,
      ),
    ),
  );
  if (results != null) {
    updateFields();
  }
}
