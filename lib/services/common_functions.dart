import 'package:at_wavi_app/common_components/custom_card.dart';
import 'package:at_wavi_app/model/user.dart';
import 'package:at_wavi_app/utils/at_enum.dart';
import 'package:at_wavi_app/utils/field_names.dart';
import 'package:at_wavi_app/view_models/user_provider.dart';
import 'package:flutter/material.dart';

class CommonFunctions {
  CommonFunctions._internal();
  static CommonFunctions _instance = CommonFunctions._internal();
  factory CommonFunctions() => _instance;

  List<Widget> getCustomCardForFields(
      ThemeData _themeData, AtCategory category) {
    return [
      ...getDefinedFieldsCard(_themeData, category),
      ...getCustomFieldsCard(_themeData, category)
    ];
  }

  List<Widget> getDefinedFieldsCard(ThemeData _themeData, AtCategory category) {
    var definedFieldsWidgets = <Widget>[];
    var userMap = User.toJson(UserProvider().user!);
    List<String> fields = FieldNames().getFieldList(category);

    for (var field in userMap.entries) {
      if (field.key != null &&
          fields.contains(field.key) &&
          field.value != null &&
          field.value.value != null) {
        var widget = Column(
          children: [
            SizedBox(
                width: double.infinity,
                child: CustomCard(
                  title: field.key,
                  subtitle: field.value.value,
                  themeData: _themeData,
                )),
            Divider(height: 1)
          ],
        );

        definedFieldsWidgets.add(widget);
      }
    }
    return definedFieldsWidgets;
  }

  List<Widget> getCustomFieldsCard(ThemeData _themeData, AtCategory category) {
    var customFieldsWidgets = <Widget>[];

    /// getting custom fields for [category]
    List<BasicData>? customFields =
        UserProvider().user!.customFields[category.name];

    if (customFields != null) {
      for (var basicData in customFields) {
        if (basicData.accountName != null && basicData.value != null) {
          var widget = Column(
            children: [
              SizedBox(
                  width: double.infinity,
                  child: CustomCard(
                    title: basicData.accountName!,
                    subtitle: basicData.value,
                    themeData: _themeData,
                  )),
              Divider(height: 1)
            ],
          );
          customFieldsWidgets.add(widget);
        }
      }
    }

    return customFieldsWidgets;
  }
}
