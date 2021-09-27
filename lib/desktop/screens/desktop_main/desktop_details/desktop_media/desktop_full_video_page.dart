import 'dart:io';

import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class DesktopFullVideoPage extends StatefulWidget {
  String path;

  DesktopFullVideoPage({
    Key? key,
    required this.path,
  }) : super(key: key);

  @override
  _DesktopFullVideoPageState createState() => _DesktopFullVideoPageState();
}

class _DesktopFullVideoPageState extends State<DesktopFullVideoPage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.path))
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return Container(
      width: 500,
      height: 500,
      color: Colors.transparent,
      child: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : Container(),
      ),
    );
  }
}
