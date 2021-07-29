import 'package:at_contact/at_contact.dart';
import 'package:at_wavi_app/model/at_follows_value.dart';

class AtFollowsList {
  List<String?>? list = [];

  AtFollowsValue? _atKey;

  /// contains details of atsigns of [list]
  List<AtsignDetails> atsignDetails = [];

  ///default it is `false`. Set `true` to make [list] as private.
  bool isPrivate = false;

  create(AtFollowsValue atValue) {
    _atKey = atValue;
    list =
        atValue.value != null && atValue.value != '' && atValue.value != 'null'
            ? atValue.value.split(',')
            : [];
    list!.toSet().toList();

    // setting initial contact data as blank
    list!.forEach((atsign) {
      atsignDetails.add(AtsignDetails(atcontact: AtContact(atSign: atsign)));
    });
  }

  add(String? value) {
    if (!list!.contains(value)) {
      list!.add(value);
    }
  }

  remove(String? value) {
    if (list!.contains(value)) {
      list!.remove(value);
    }
  }

  addAll(List<String> value) {
    for (String val in value) {
      this.add(val);
    }
  }

  removeAll(List<String> value) {
    for (String val in value) {
      this.remove(val);
    }
  }

  contains(String? value) {
    return list!.contains(value);
  }

  toString() {
    return list!.join(',');
  }

  set setKey(AtFollowsValue key) {
    this._atKey = key;
  }

  AtFollowsValue? get getKey => _atKey;
}
