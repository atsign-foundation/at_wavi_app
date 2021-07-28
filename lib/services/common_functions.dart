import 'package:at_wavi_app/common_components/custom_card.dart';
import 'package:at_wavi_app/common_components/custom_media_card.dart';
import 'package:at_wavi_app/model/user.dart';
import 'package:at_wavi_app/services/twitter_service.dart';
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
            Divider(
                height: 1, color: _themeData.highlightColor.withOpacity(0.5))
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
                child: checkForCustomContentType(basicData, _themeData),
              ),
              Divider(
                  height: 1, color: _themeData.highlightColor.withOpacity(0.5))
            ],
          );
          customFieldsWidgets.add(
            widget,
          );
        }
      }
    }

    return customFieldsWidgets;
  }

  Widget checkForCustomContentType(BasicData basicData, ThemeData _themeData) {
    Widget fieldCard = SizedBox();
    if (basicData.type == CustomContentType.Text.name ||
        basicData.type == CustomContentType.Number.name) {
      fieldCard = CustomCard(
        title: basicData.accountName!,
        subtitle: basicData.value,
        themeData: _themeData,
      );
    } else if (basicData.type == CustomContentType.Image.name ||
        basicData.type == CustomContentType.Youtube.name) {
      fieldCard = CustomMediaCard(
        basicData: basicData,
        themeData: _themeData,
      );
    } else if (basicData.type == CustomContentType.Link.name) {
      fieldCard = CustomCard(
        title: basicData.accountName!,
        subtitle: basicData.value,
        themeData: _themeData,
        isUrl: true,
      );
    }
    return fieldCard;
  }

  List<Widget> getFeaturedTwitterCards(ThemeData _themeData) {
    var twitterCards = <Widget>[];
    if (TwitetrService().tweetList.isNotEmpty) {
      int sliceIndex = TwitetrService().tweetList.length > 5
          ? 5
          : TwitetrService().tweetList.length;

      TwitetrService().tweetList.sublist(0, sliceIndex).forEach((tweet) {
        var twitterCard = Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: CustomCard(
                subtitle: tweet.text,
                themeData: _themeData,
              ),
            ),
            Divider(
              height: 1,
              color: _themeData.highlightColor.withOpacity(0.5),
            )
          ],
        );

        twitterCards.add(twitterCard);
      });
    }

    return twitterCards;
  }

  bool isFieldsPresentForCategory(AtCategory category) {
    var isPresent = false;
    var userMap = User.toJson(UserProvider().user!);
    List<String> fields = FieldNames().getFieldList(category);

    for (var field in userMap.entries) {
      if (field.key != null &&
          fields.contains(field.key) &&
          field.value != null &&
          field.value.value != null) {
        isPresent = true;
      }
    }

    if (!isPresent) {
      List<BasicData>? customFields =
          UserProvider().user!.customFields[category.name];

      if (customFields != null) {
        for (var basicData in customFields) {
          if (basicData.accountName != null && basicData.value != null) {
            isPresent = true;
          }
        }
      }
    }

    return isPresent;
  }

  bool isTwitterFeatured() {
    if (UserProvider().user != null &&
        UserProvider().user!.twitter.value != null) {
      return true;
    } else {
      return false;
    }
  }

  bool isInstagramFeatured() {
    if (UserProvider().user != null &&
        UserProvider().user!.instagram.value != null) {
      return true;
    } else {
      return false;
    }
  }
}
