import 'package:at_wavi_app/model/user.dart';
import 'package:at_wavi_app/utils/at_enum.dart';
import 'package:at_wavi_app/utils/at_key_constants.dart';
import 'package:at_wavi_app/view_models/base_model.dart';
import 'package:validators/validators.dart';

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

// deletes any custom key from preview data.
  addFieldToDelete(AtCategory category, BasicData basicData) {
    List<BasicData>? customFields = _user!.customFields[category.name];

    customFields!.add(BasicData(
        accountName: basicData.accountName! + AtText.IS_DELETED,
        isPrivate: basicData.isPrivate));
  }

  deletCustomField(AtCategory category, BasicData basicData) {
    List<BasicData>? customFields = _user!.customFields[category.name];
    var index = customFields!.indexOf(basicData);
    customFields[index] = BasicData(
        accountName: customFields[index].accountName! + AtText.IS_DELETED,
        isPrivate: customFields[index].isPrivate);
  }

  bool isFormDataValid(value, CustomContentType type) {
    switch (type) {
      case CustomContentType.Link:
        return isURL(value);

      case CustomContentType.Youtube:
        return RegExp(AtText.YOUTUBE_PATTERN).hasMatch(value);

      default:
        return false;
    }
  }

  iskeyNameTaken(BasicData basicData) {
    String fieldName = _formatFieldName(basicData.accountName!);
    bool response = false;
    var customFields = _user!.customFields;
    var values = customFields.values;
    for (var basicDataList in values) {
      var result = basicDataList.indexWhere((data) {
        return _formatFieldName(data.accountName!) == fieldName;
      });
      if (result != -1) {
        return true;
      }
    }

    var _mapRep = User.toJson(_user!);
    response = _mapRep.containsKey(fieldName);

    return response;
  }

  String _formatFieldName(String fieldname) {
    return fieldname.trim().toLowerCase().replaceAll(' ', '');
  }
}
