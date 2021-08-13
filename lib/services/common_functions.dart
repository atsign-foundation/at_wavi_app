import 'dart:typed_data';

import 'package:at_contact/at_contact.dart';
import 'package:at_contacts_flutter/at_contacts_flutter.dart';
import 'package:at_lookup/at_lookup.dart';
import 'package:at_wavi_app/common_components/custom_card.dart';
import 'package:at_wavi_app/common_components/custom_media_card.dart';
import 'package:at_wavi_app/model/user.dart';
import 'package:at_wavi_app/services/nav_service.dart';
import 'package:at_wavi_app/services/twitter_service.dart';
import 'package:at_wavi_app/utils/at_enum.dart';
import 'package:at_wavi_app/utils/colors.dart';
import 'package:at_wavi_app/utils/constants.dart';
import 'package:at_wavi_app/utils/field_names.dart';
import 'package:at_wavi_app/utils/text_styles.dart';
import 'package:at_wavi_app/view_models/user_preview.dart';
import 'package:at_wavi_app/view_models/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommonFunctions {
  CommonFunctions._internal();
  static CommonFunctions _instance = CommonFunctions._internal();
  factory CommonFunctions() => _instance;

  List<Widget> getCustomCardForFields(ThemeData _themeData, AtCategory category,
      {bool isPreview = false}) {
    return [
      ...getDefinedFieldsCard(_themeData, category, isPreview: isPreview),
      ...getCustomFieldsCard(_themeData, category, isPreview: isPreview)
    ];
  }

  List<Widget> getDefinedFieldsCard(ThemeData _themeData, AtCategory category,
      {bool isPreview = false}) {
    var definedFieldsWidgets = <Widget>[];
    var userMap = User.toJson(isPreview
        ? Provider.of<UserPreview>(NavService.navKey.currentContext!,
                listen: false)
            .user()
        : UserProvider().user!);
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

  List<Widget> getCustomFieldsCard(ThemeData _themeData, AtCategory category,
      {bool isPreview = false}) {
    var customFieldsWidgets = <Widget>[];

    /// getting custom fields for [category]
    List<BasicData>? customFields = [];
    if (isPreview) {
      customFields = Provider.of<UserPreview>(NavService.navKey.currentContext!,
              listen: false)
          .user()!
          .customFields[category.name];
    } else {
      customFields = UserProvider().user!.customFields[category.name];
    }

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

  bool isFieldsPresentForCategory(AtCategory category,
      {bool isPreview = false}) {
    if (isPreview &&
        Provider.of<UserPreview>(NavService.navKey.currentContext!,
                    listen: false)
                .user() ==
            null) {
      return false;
    }
    if (UserProvider().user == null) {
      return false;
    }
    var userMap = User.toJson(isPreview
        ? Provider.of<UserPreview>(NavService.navKey.currentContext!,
                listen: false)
            .user()!
        : UserProvider().user!);
    var isPresent = false;
    List<String> fields = FieldNames().getFieldList(category);

    for (var field in userMap.entries) {
      if (field.key != null &&
          fields.contains(field.key) &&
          field.value != null &&
          field.value.value != null) {
        return true;
      }
    }

    if (!isPresent) {
      List<BasicData>? customFields = [];

      if (isPreview) {
        customFields = Provider.of<UserPreview>(
                NavService.navKey.currentContext!,
                listen: false)
            .user()!
            .customFields[category.name];
      } else {
        customFields = UserProvider().user!.customFields[category.name];
      }

      if (customFields != null) {
        for (var basicData in customFields) {
          if (basicData.accountName != null && basicData.value != null) {
            return true;
          }
        }
      }
    }

    return isPresent;
  }

  bool isTwitterFeatured({bool isPreview = false}) {
    if (isPreview) {
      if (Provider.of<UserPreview>(NavService.navKey.currentContext!,
                      listen: false)
                  .user() !=
              null &&
          Provider.of<UserPreview>(NavService.navKey.currentContext!,
                      listen: false)
                  .user()!
                  .twitter
                  .value !=
              null) {
        return true;
      } else {
        return false;
      }
    }

    if (UserProvider().user != null &&
        UserProvider().user!.twitter.value != null) {
      return true;
    } else {
      return false;
    }
  }

  bool isInstagramFeatured({bool isPreview = false}) {
    if (isPreview) {
      if (Provider.of<UserPreview>(NavService.navKey.currentContext!,
                      listen: false)
                  .user() !=
              null &&
          Provider.of<UserPreview>(NavService.navKey.currentContext!,
                      listen: false)
                  .user()!
                  .instagram
                  .value !=
              null) {
        return true;
      } else {
        return false;
      }
    }

    if (UserProvider().user != null &&
        UserProvider().user!.instagram.value != null) {
      return true;
    } else {
      return false;
    }
  }

  getCachedContactImage(String atsign) {
    Uint8List image;
    AtContact contact = checkForCachedContactDetail(atsign);

    if (contact != null &&
        contact.tags != null &&
        contact.tags!['image'] != null) {
      List<int> intList = contact.tags!['image'].cast<int>();
      image = Uint8List.fromList(intList);
      return image;
    }
  }

  Future<bool> checkAtsign(String? receiver) async {
    if (receiver == null) {
      return false;
    } else if (!receiver.contains('@')) {
      receiver = '@' + receiver;
    }
    var checkPresence = await AtLookupImpl.findSecondary(
        receiver, MixedConstants.ROOT_DOMAIN, 64);
    return checkPresence != null;
  }

  showSnackBar(String msg) {
    ScaffoldMessenger.of(NavService.navKey.currentContext!)
        .showSnackBar(SnackBar(
      backgroundColor: ColorConstants.RED,
      content: Text(
        msg,
        style: CustomTextStyles.customTextStyle(
          ColorConstants.white,
        ),
      ),
    ));
  }
}
