import 'package:at_wavi_app/desktop/screens/desktop_home/desktop_side_menu.dart';
import 'package:flutter/cupertino.dart';

class DesktopHomeModel extends ChangeNotifier {
  DesktopSideMenu _selectedMenu = DesktopSideMenu.profile;

  DesktopSideMenu get selectedMenu => _selectedMenu;

  DesktopHomeModel(){

  }

  void changeMenu(DesktopSideMenu menu) {
    _selectedMenu = menu;
    notifyListeners();
  }
}
