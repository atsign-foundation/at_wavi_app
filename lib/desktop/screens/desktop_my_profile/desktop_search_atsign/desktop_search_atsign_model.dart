import 'package:at_wavi_app/desktop/utils/load_status.dart';
import 'package:at_wavi_app/model/user.dart';
import 'package:at_wavi_app/services/search_service.dart';
import 'package:at_wavi_app/view_models/user_preview.dart';
import 'package:flutter/cupertino.dart';

class DesktopSearchAtSignModel extends ChangeNotifier {
  final UserPreview userPreview;

  List<User> _users = [];
  LoadStatus _searchStatus = LoadStatus.initial;

  List<User> get users => _users;

  LoadStatus get searchStatus => _searchStatus;

  DesktopSearchAtSignModel({required this.userPreview});

  void searchAtSignAccount({required String keyword}) async {
    _searchStatus = LoadStatus.loading;
    notifyListeners();
    SearchInstance? _searchService =
        await SearchService().getAtsignDetails(keyword);
    User? user = _searchService?.user;
    _users = user == null ? [] : [user];
    _searchStatus = LoadStatus.success;
    notifyListeners();
  }

// void searchUser(String text) {
//   _searchUsers.clear();
//   for (int i = 0; i < _users.length; i++) {
//     if (_users[i].atsign.toLowerCase().contains(text)) {
//       _searchUsers.add(_users[i]);
//     }
//   }
//   notifyListeners();
// }
}
