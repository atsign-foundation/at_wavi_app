import 'package:at_wavi_app/model/user.dart';
import 'package:at_wavi_app/view_models/base_model.dart';

class UserPreview extends BaseModel {
  UserPreview._();
  static UserPreview _instance = UserPreview._();
  factory UserPreview() => _instance;

  User? _user;

  set setUser(User? user) {
    this._user = user;
  }

  setSearchedUser(User? user) {
    this._user = user;
  }

  User? user() {
    return _user;
  }

  void notify() {
    notifyListeners();
  }
}
