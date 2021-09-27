import 'dart:io';

import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
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
    return Container(
      width: 500,
      height: 500,
      color: Colors.transparent,
      child: Center(
        child: Image.file(
          File(widget.path),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
