import 'package:at_wavi_app/model/user.dart';

bool areBasicDataEqual(BasicData previousData, BasicData newData) {
  if (previousData.value != newData.value) {
    return false;
  }

  if (previousData.isPrivate != newData.isPrivate) {
    return false;
  }

  if (previousData.accountName != newData.accountName) {
    return false;
  }

  if (previousData.valueDescription != newData.valueDescription) {
    return false;
  }

  if (previousData.type != newData.type) {
    return false;
  }

  return true;
}
