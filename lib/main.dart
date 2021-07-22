import 'dart:async';

import 'package:at_wavi_app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runZoned<Future<void>>(() async {
    // ignore: unawaited_futures
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]).then((_) {
      runApp(MyApp());
    });
  });
}
