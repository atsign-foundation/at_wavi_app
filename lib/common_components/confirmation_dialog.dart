// import 'package:at_common_flutter/at_common_flutter.dart' as CommonFlutter;
import 'package:at_wavi_app/services/nav_service.dart';
import 'package:at_wavi_app/services/size_config.dart';
import 'package:at_wavi_app/utils/text_styles.dart';
// import 'package:at_wavi_app/services/size_config.dart' as SizeConfig;
import 'package:flutter/material.dart';

import 'custom_button.dart';

Future<bool?> confirmationDialog(String atsign) async {
  bool? _choice;
  await showDialog<bool>(
    context: NavService.navKey.currentContext!,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return Container(
        width: SizeConfig().screenWidth * 0.8,
        child: AlertDialog(
          contentPadding: EdgeInsets.fromLTRB(15, 30, 15, 20),
          content: SingleChildScrollView(
            child: Container(
              child: Column(
                children: <Widget>[
                  Text(
                    'Are you sure, you want to unfollow $atsign ?',
                    style: TextStyles.grey16,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30),
                  CustomButton(
                    onTap: () {
                      _choice = true;
                      Navigator.pop(NavService.navKey.currentContext!, _choice);
                    },
                    bgColor: Theme.of(context).primaryColor,
                    width: 164.toWidth,
                    height: 48.toHeight,
                    child: Text(
                      'Yes!',
                      style: TextStyle(
                          fontSize: 15.toFont,
                          color: Theme.of(context).scaffoldBackgroundColor),
                    ),
                  ),
                  SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      _choice = false;
                      Navigator.pop(NavService.navKey.currentContext!, _choice);
                    },
                    child: Text(
                      'No',
                      style: CustomTextStyles.black(size: 14),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
  return _choice;
}
