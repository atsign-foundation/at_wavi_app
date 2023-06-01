import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:flutter/material.dart';

import 'item/desktop_new_request_item.dart';

class DesktopNewRequestPage extends StatefulWidget {
  const DesktopNewRequestPage({Key? key}) : super(key: key);

  @override
  _DesktopNewRequestPageState createState() => _DesktopNewRequestPageState();
}

class _DesktopNewRequestPageState extends State<DesktopNewRequestPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 5,
      shrinkWrap: true,
      separatorBuilder: (context, index) {
        return Divider(
          color: Colors.transparent,
          height: 0.5,
        );
      },
      itemBuilder: (context, i) {
        return DesktopNewRequestItem();
      },
    );
  }
}
