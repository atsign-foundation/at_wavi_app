import 'package:flutter/cupertino.dart';

import 'desktop_side_menu.dart';

class DesktopEditProfileModel extends ChangeNotifier {
  DesktopSideMenu _selectedMenu = DesktopSideMenu.profile;

  DesktopSideMenu get selectedMenu => _selectedMenu;

  void changeMenu(DesktopSideMenu menu) {
    _selectedMenu = menu;
    notifyListeners();
  }
}
