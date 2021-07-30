import 'package:at_commons/at_commons.dart';
import 'package:at_contact/at_contact.dart';

class AtFollowsValue extends AtValue {
  late AtKey atKey;
}

class AtsignDetails {
  AtContact atcontact;
  bool isUnfollowing;
  bool isRmovingFromFollowers;
  AtsignDetails({
    required this.atcontact,
    this.isUnfollowing = false,
    this.isRmovingFromFollowers = false,
  });
}
