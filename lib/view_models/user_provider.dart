import 'package:at_wavi_app/model/user.dart';
import 'package:at_wavi_app/services/at_key_get_service.dart';
import 'package:at_wavi_app/services/at_key_set_service.dart';
import 'package:at_wavi_app/services/backend_service.dart';
import 'package:at_wavi_app/services/field_order_service.dart';
import 'package:at_wavi_app/services/twitter_service.dart';
import 'package:at_wavi_app/view_models/base_model.dart';

class UserProvider extends BaseModel {
  UserProvider._();
  static UserProvider _instance = UserProvider._();
  factory UserProvider() => _instance;

  User? user;
  String FETCH_USER = 'fetch_user_data';
  final String UPDATE_USER = 'update_user';

  fetchUserData(String atsign) async {
    setStatus(FETCH_USER, Status.Loading);
    user = await AtKeyGetService().getProfile(atsign: atsign);
    if (user == null) {
      setStatus(FETCH_USER, Status.Error);
      return;
    }
    await TwitetrService().getTweets();
    setStatus(FETCH_USER, Status.Done);
  }

  void notify() {
    notifyListeners();
  }

  saveUserData(User user) async {
    setStatus(UPDATE_USER, Status.Loading);
    try {
      var atKeys = await AtKeySetService().getAtkeys();
      await FieldOrderService().updateFieldsOrder();
      await AtKeySetService().updateDefinedFields(user, true, atKeys);
      await AtKeySetService().updateCustomData(user, true, atKeys);
      await BackendService().sync();
      setStatus(UPDATE_USER, Status.Done);
    } catch (e) {
      print('error in saveUserData : $e');
      setError(UPDATE_USER, e.toString());
      setStatus(UPDATE_USER, Status.Error);
    }
  }
}
