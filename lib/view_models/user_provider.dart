import 'package:at_wavi_app/model/user.dart';
import 'package:at_wavi_app/services/at_key_get_service.dart';
import 'package:at_wavi_app/services/twitter_service.dart';
import 'package:at_wavi_app/view_models/base_model.dart';

class UserProvider extends BaseModel {
  UserProvider._();
  static UserProvider _instance = UserProvider._();
  factory UserProvider() => _instance;

  User? user;
  String FETCH_USER = 'fetch_user_data';

  fetchUserData(String atsign) async {
    setStatus(FETCH_USER, Status.Loading);
    user = await AtKeyGetService().getProfile(atsign: atsign);
    if (user == null) {
      setStatus(FETCH_USER, Status.Error);
    }
    await TwitetrService().getTweets();
    setStatus(FETCH_USER, Status.Done);
  }

  void notify() {
    notifyListeners();
  }
}
