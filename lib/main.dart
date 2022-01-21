// @dart=2.9
import 'dart:async';

import 'package:at_wavi_app/app.dart';
import 'package:at_wavi_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runZoned<Future<void>>(() async {
    await MixedConstants.load();
    // ignore: unawaited_futures
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]).then((_) {
      runApp(MyApp());
    });
  });
}
