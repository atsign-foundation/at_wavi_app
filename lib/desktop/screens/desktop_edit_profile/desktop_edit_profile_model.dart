import 'package:flutter/cupertino.dart';

import 'desktop_side_menu.dart';

class DesktopEditProfileModel extends ChangeNotifier {
  DesktopSideMenu _selectedMenu = DesktopSideMenu.profile;

  DesktopSideMenu get selectedMenu => _selectedMenu;

  void changeMenu(DesktopSideMenu menu) {
    _selectedMenu = menu;
    notifyListeners();
  }

  /// Jump to next page
  /// return true if jump success
  /// return false if can't jump
  bool jumpNextPage() {
    if (DesktopSideMenu.values.length == _selectedMenu.index - 1) {
      return false;
    } else {
      _selectedMenu = DesktopSideMenu.values[_selectedMenu.index + 1];
      notifyListeners();
      return true;
    }
  }
}
