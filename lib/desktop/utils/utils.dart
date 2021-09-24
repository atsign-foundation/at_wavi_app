import 'package:at_wavi_app/model/user.dart';
import 'package:at_wavi_app/utils/colors.dart';
import 'package:flutter/material.dart';

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

void showSnackBar(BuildContext context, String message, Color color) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Container(
        padding: EdgeInsets.all(8),
        child: Text(
          message,
          style: TextStyle(
            color: ColorConstants.white,
            fontSize: 14,
          ),
        ),
      ),
      backgroundColor: color,
      duration: Duration(
        seconds: 2,
      ),
    ),
  );
}


