import 'dart:io';
import 'dart:math';

import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter/material.dart';
//import 'package:video_player/video_player.dart';

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
  // late VideoPlayerController _controller;
  late Player _player;

  @override
  void initState() {
    // _controller = VideoPlayerController.file(File(widget.path))
    //   ..initialize().then((_) {
    //     setState(() {});
    //   });
    _player = Player(id: Random().nextInt(1000));
    _player.open(
      Media.file(File(widget.path)),
      autoStart: true, // default
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return Container(
      width: 600,
      height: 600,
      color: Colors.transparent,
      child: Center(
        child: Video(
          player: _player,
          height: 600,
          width: 600,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }
}
