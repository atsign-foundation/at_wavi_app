import 'dart:io';

import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/utils/colors.dart';
import 'package:flutter/material.dart';

class DesktopFullImagePage extends StatefulWidget {
  String path;

  DesktopFullImagePage({
    Key? key,
    required this.path,
  }) : super(key: key);

  @override
  _DesktopFullImagePageState createState() => _DesktopFullImagePageState();
}

class _DesktopFullImagePageState extends State<DesktopFullImagePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return Stack(
      children: [
        Container(
          width: 500,
          height: 500,
          color: Colors.transparent,
          child: Center(
            child: Image.file(
              File(widget.path),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Positioned(
          right: 8,
          top: 0,
          child: IconButton(
            icon: Icon(
              Icons.clear,
              size: 32,
              color: ColorConstants.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ],
    );
  }
}
