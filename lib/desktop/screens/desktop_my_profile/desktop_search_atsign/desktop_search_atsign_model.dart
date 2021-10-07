import 'package:at_wavi_app/model/user.dart';
import 'package:at_wavi_app/view_models/user_preview.dart';
import 'package:flutter/cupertino.dart';

class DesktopSearchAtSignModel extends ChangeNotifier {
  final UserPreview userPreview;

  List<User> _users = [];
  List<User> _searchUsers = [];

  List<User> get users => _users;

  List<User> get searchUsers => _searchUsers;

  late TextEditingController searchTextEditingController;

  DesktopSearchAtSignModel({required this.userPreview}) {
    searchTextEditingController = TextEditingController(
      text: '',
    );
    for (int i = 0; i < 6; i++) {
      _users.add(User(atsign: 'AtSing$i'));
    }
    searchUser('');
  }

  void searchUser(String text) {
    _searchUsers.clear();
    for (int i = 0; i < _users.length; i++) {
      if (_users[i].atsign.toLowerCase().contains(text)) {
        _searchUsers.add(_users[i]);
      }
    }
    notifyListeners();
  }
}
