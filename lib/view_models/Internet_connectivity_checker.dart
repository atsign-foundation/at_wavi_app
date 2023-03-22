import 'dart:async';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class InternetConnectivityChecker extends ChangeNotifier {
  bool isInternetAvailable = false;
  late StreamSubscription _listener;

  checkConnectivity() async {
    isInternetAvailable = await InternetConnectionChecker().hasConnection;

    _listener = InternetConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          isInternetAvailable = true;
          break;
        case InternetConnectionStatus.disconnected:
          isInternetAvailable = false;
          break;
      }

      notifyListeners();
    });

    notifyListeners();
  }

  unsubscribe() {
    _listener.cancel();
  }
}
