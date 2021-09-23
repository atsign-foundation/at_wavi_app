import 'package:at_wavi_app/model/user.dart';

List<BasicData> sortBasicData(
    List<BasicData> listBasicData, List<String> listTitle) {
  List<BasicData> newListBasicData = [];
  for (int i = 0; i < listTitle.length; i++) {
    var newBasicData = listBasicData.firstWhere(
            (element) => element.accountName == listTitle[i],
        orElse: () => BasicData());
    if (newBasicData.accountName != null &&
        newBasicData.accountName!.isNotEmpty) {
      newListBasicData.add(newBasicData);
    }
  }
  return newListBasicData;
}