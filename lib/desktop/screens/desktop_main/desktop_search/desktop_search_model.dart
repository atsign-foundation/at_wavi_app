import 'package:at_wavi_app/model/user.dart';
import 'package:at_wavi_app/view_models/user_preview.dart';
import 'package:flutter/cupertino.dart';

class DesktopSearchModel extends ChangeNotifier {
  final UserPreview userPreview;

  List<User> _users = [];
  List<User> _searchUsers = [];

  List<User> get users => _users;

  List<User> get searchUsers => _searchUsers;

  late TextEditingController searchTextEditingController;

  DesktopSearchModel({required this.userPreview}) {
    //  FieldOrderService().initCategoryFields(AtCategory.DETAILS);
    searchTextEditingController = TextEditingController(
      text: '',
    );
    searchUser('');
  }

  void searchUser(String text) {
    _searchUsers.clear();
    for (int i = 0; i < text.length; i++) {
      _searchUsers.add(
        User(atsign: 'duc$i'),
      );
    }
    notifyListeners();
  }
}
