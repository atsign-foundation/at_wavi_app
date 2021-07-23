import 'package:at_wavi_app/model/user.dart';
import 'package:at_wavi_app/services/at_key_service.dart';
import 'package:at_wavi_app/view_models/base_model.dart';

class UserProvider extends BaseModel {
  UserProvider._();
  static UserProvider _instance = UserProvider._();
  factory UserProvider() => _instance;

  User? user;
  String FETCH_USER = 'fetach_user_data';

  fetchUserData(String atsign) async {
    setStatus(FETCH_USER, Status.Loading);
    var data = await AtKeyService().getProfile(atsign: atsign);
    print('fetched user daya: ${data!.about}');
    setStatus(FETCH_USER, Status.Loading);
  }
}
