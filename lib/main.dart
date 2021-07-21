import 'dart:async';

import 'package:at_wavi_app/app.dart';
import 'package:at_wavi_app/view_models/theme_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  var themeProvider = ThemeProvider(themeColor: ThemeColor.Light);
  WidgetsFlutterBinding.ensureInitialized();
  runZoned<Future<void>>(() async {
    ThemeColor _themeColor = await themeProvider.checkTheme();
    // ignore: unawaited_futures
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]).then((_) {
      runApp(MyApp(currentTheme: _themeColor));
    });
  });
}
