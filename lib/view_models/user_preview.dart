import 'package:at_wavi_app/model/user.dart';
import 'package:at_wavi_app/utils/at_enum.dart';
import 'package:at_wavi_app/utils/at_key_constants.dart';
import 'package:at_wavi_app/view_models/base_model.dart';

class UserPreview extends BaseModel {
  UserPreview._();
  static UserPreview _instance = UserPreview._();
  factory UserPreview() => _instance;

  User? _user;

  set setUser(User? user) {
    this._user = user;
  }

  User? user() {
    return _user;
  }

  void notify() {
    notifyListeners();
  }

// deletes any custom key from preview data.
  deleteCustomField(AtCategory category, BasicData basicData) {
    List<BasicData>? customFields = _user!.customFields[category.name];

    customFields!.add(BasicData(
        accountName: basicData.accountName! + AtText.IS_DELETED,
        isPrivate: basicData.isPrivate));
  }
}
