import 'package:at_client/at_client.dart';
import 'package:at_wavi_app/services/backend_service.dart';
import 'package:flutter/material.dart';

class DesktopLoginModel extends ChangeNotifier {
  AtClientPreference? atClientPreference;

  void checkToOnboard() async {
    String? currentAtSign = await BackendService().getAtSign();
    await BackendService()
        .getAtClientPreference()
        .then((value) => atClientPreference = value)
        .catchError((e) => print(e));

    if (currentAtSign != null && currentAtSign != '') {
      await BackendService()
          .onboard(currentAtSign, atClientPreference: atClientPreference);
    }
    notifyListeners();
  }
}
