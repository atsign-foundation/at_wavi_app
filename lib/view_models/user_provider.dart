import 'dart:convert';

import 'package:at_wavi_app/model/user.dart';
import 'package:at_wavi_app/services/at_key_get_service.dart';
import 'package:at_wavi_app/services/at_key_set_service.dart';
import 'package:at_wavi_app/services/backend_service.dart';
import 'package:at_wavi_app/services/field_order_service.dart';
import 'package:at_wavi_app/services/twitter_service.dart';
import 'package:at_wavi_app/view_models/base_model.dart';

import '../services/exception_service.dart';

class UserProvider extends BaseModel {
  User? user;
  String FETCH_USER = 'fetch_user_data';
  final String UPDATE_USER = 'update_user';

  fetchUserData(String atsign) async {
    setStatus(FETCH_USER, Status.Loading);
    user = await AtKeyGetService().getProfile(atsign: atsign);
    if (user!.atsign == '') {
      user!.atsign = atsign;
    }

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
      if (user.twitter.value != this.user!.twitter.value) {
        await TwitetrService().getTweets();
      }
      var _definedFieldsResult =
          await AtKeySetService().updateDefinedFields(user, true, atKeys);
      var _customFieldsResult =
          await AtKeySetService().updateCustomData(user, true, atKeys);
      await BackendService().sync();
      this.user = User.fromJson(json.decode(json.encode(User.toJson(user))));
      if (!_definedFieldsResult || !_customFieldsResult) {
        setError(UPDATE_USER, 'Something went wrong while saving keys');
        setStatus(UPDATE_USER, Status.Error);
      } else {
        setStatus(UPDATE_USER, Status.Done);
      }
    } catch (e) {
      print('error in saveUserData : $e');
      setError(UPDATE_USER, e.toString());
      setStatus(UPDATE_USER, Status.Error);
      ExceptionService.instance.showGetExceptionOverlay(e);
    }
  }
}
