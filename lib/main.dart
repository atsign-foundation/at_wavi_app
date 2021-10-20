// @dart=2.9
import 'dart:async';
import 'dart:io';

import 'package:at_wavi_app/app.dart';
// import 'package:dart_vlc/dart_vlc.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'desktop/services/hive/hive_service.dart';


import 'package:path_provider/path_provider.dart' as path_provider;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HiveService().initHive();
  runZoned<Future<void>>(() async {
    print(await path_provider.getApplicationDocumentsDirectory());
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      await DesktopWindow.setWindowSize(Size(1366, 768));
      await DesktopWindow.setMinWindowSize(Size(1200, 700));
      // DartVLC.initialize();
    }
    // ignore: unawaited_futures
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]).then((_) {
      runApp(MyApp());
    });
  });
}
