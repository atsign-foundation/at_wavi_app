import 'package:at_wavi_app/model/user.dart';
import 'package:at_wavi_app/services/field_order_service.dart';
import 'package:at_wavi_app/utils/at_enum.dart';
import 'package:at_wavi_app/utils/field_names.dart';
import 'package:at_wavi_app/view_models/user_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class DesktopFollowingModel extends ChangeNotifier {
  final UserPreview userPreview;

  List<User> _users = [];

  List<User> get users => _users;

  late TextEditingController followingTextEditingController;

  DesktopFollowingModel({required this.userPreview}) {
    //  FieldOrderService().initCategoryFields(AtCategory.DETAILS);
    followingTextEditingController = TextEditingController(
      text: '',
    );
    searchUser('');
  }

  void searchUser(String text) {
    _users.clear();
    for(int i = 0; i < text.length; i++){
      _users.add(User());
    }
    notifyListeners();
  }
}
