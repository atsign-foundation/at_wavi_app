import 'dart:typed_data';

import 'package:at_wavi_app/common_components/add_custom_content_button.dart';
import 'package:at_wavi_app/common_components/public_private_bottomsheet.dart';
import 'package:at_wavi_app/model/user.dart';
import 'package:at_wavi_app/routes/route_names.dart';
import 'package:at_wavi_app/routes/routes.dart';
import 'package:at_wavi_app/utils/at_enum.dart';
import 'package:at_wavi_app/utils/at_key_constants.dart';
import 'package:at_wavi_app/utils/colors.dart';
import 'package:at_wavi_app/utils/field_names.dart';
import 'package:at_wavi_app/utils/text_styles.dart';
import 'package:at_wavi_app/view_models/user_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class EditCategoryFields extends StatefulWidget {
  final AtCategory category;
  final String filedHeading;
  EditCategoryFields({required this.category, required this.filedHeading});

  @override
  _EditCategoryFieldsState createState() => _EditCategoryFieldsState();
}

class _EditCategoryFieldsState extends State<EditCategoryFields> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorConstants.white,
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: SafeArea(
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.of(context).pop();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: ColorConstants.RED,
                            content: Text(
                              'Please fill all custom details',
                              style: CustomTextStyles.customTextStyle(
                                ColorConstants.white,
                              ),
                            ),
                          ));
                        }
                      },
                      child: Row(
                        children: [
                          Icon(Icons.arrow_back),
                          SizedBox(width: 5),
                          Text(
                            widget.filedHeading,
                            style: TextStyles.boldText(Colors.black, size: 16),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        showPublicPrivateBottomSheet(
                            onPublicClicked: () {
                              changeFiledsVisibility(false);
                            },
                            onPrivateClicked: () {
                              changeFiledsVisibility(true);
                            },
                            height: 160);
                      },
                      child: Icon(
                          isAllFieldsPrivate() ? Icons.lock : Icons.public),
                    )
                  ],
                ),
              ),
              SizedBox(height: 35),
              Form(
                key: _formKey,
                child: Expanded(
                    child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: getAllInputFields(),
                  ),
                )),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: AddCustomContentButton(
                  text: 'Add custom content',
                  onTap: () {
                    SetupRoutes.push(context, Routes.ADD_CUSTOM_FIELD,
                        arguments: {
                          'onSave': (BasicData data, int index) {
                            List<BasicData>? customFields = UserPreview()
                                .user()!
                                .customFields[widget.category.name];
                            if (customFields != null) {
                              setState(() {
                                customFields.add(data);
                                UserPreview()
                                        .user()!
                                        .customFields[widget.category.name] =
                                    customFields;
                              });
                            }
                          },
                          'isEdit': false,
                          'category': widget.category
                        });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> getAllInputFields() {
    return [...getDefinedInputFields(), ...getCustomInputFields()];
  }

  List<Widget> getDefinedInputFields() {
    var definedFieldsWidgets = <Widget>[];
    var userMap =
        User.toJson(Provider.of<UserPreview>(context, listen: false).user());
    List<FieldsEnum> fields = FieldNames().getFieldListEnum(widget.category);

    for (int i = 0; i < fields.length; i++) {
      BasicData basicData = userMap[fields[i].name];
      if (basicData.value == null && basicData.accountName == null) {
        basicData = BasicData(
          accountName: fields[i].name,
          value: '',
          type: CustomContentType.Text.name,
        );
      }

      var widget = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              basicData.accountName!,
              style: TextStyles.lightText(ColorConstants.black.withOpacity(0.5),
                  size: 16),
            ),
          ),
          inputField(basicData),
          Divider(thickness: 1, height: 1),
          SizedBox(height: 20)
        ],
      );

      definedFieldsWidgets.add(widget);
    }

    return definedFieldsWidgets;
  }

  List<Widget> getCustomInputFields() {
    var customFieldsWidgets = <Widget>[];
    List<BasicData>? customFields =
        Provider.of<UserPreview>(context, listen: false)
            .user()!
            .customFields[widget.category.name];

    if (customFields != null) {
      for (var basicData in customFields) {
        if (basicData.accountName != null && basicData.value != null) {
          var widget = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: checkForCustomContentType(basicData),
              ),
            ],
          );
          customFieldsWidgets.add(widget);
        }
      }
    }
    return customFieldsWidgets;
  }

  Widget checkForCustomContentType(BasicData basicData) {
    if (basicData.type == CustomContentType.Text.name ||
        basicData.type == CustomContentType.Number.name ||
        basicData.type == CustomContentType.Link.name ||
        basicData.type == CustomContentType.Youtube.name) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              basicData.accountName!,
              style: TextStyles.lightText(ColorConstants.black.withOpacity(0.5),
                  size: 16),
            ),
          ),
          inputField(basicData, isCustomField: true),
          Divider(thickness: 1, height: 1),
          SizedBox(height: 20)
        ],
      );

      // to show image content
    } else if (basicData.type == CustomContentType.Image.name) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  basicData.accountName!,
                  style: TextStyles.lightText(
                      ColorConstants.black.withOpacity(0.5),
                      size: 16),
                ),
              ),
              InkWell(
                onTap: () {
                  SetupRoutes.push(context, Routes.ADD_CUSTOM_FIELD,
                      arguments: {
                        'onSave': (BasicData updatedData, int index) {
                          List<BasicData>? customFields = UserPreview()
                              .user()!
                              .customFields[widget.category.name];
                          if (index > -1) {
                            setState(() {
                              customFields![index] = updatedData;
                            });
                          } else {
                            customFields!.add(updatedData);
                          }
                        },
                        'basicData': basicData,
                        'isEdit': true,
                        'category': widget.category
                      });
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(Icons.edit),
                ),
              )
            ],
          ),
          imageField(basicData),
          Divider(thickness: 1, height: 1),
          SizedBox(height: 20)
        ],
      );
    }
    return SizedBox();
  }

  Widget inputField(BasicData basicData, {bool isCustomField = false}) {
    print('basicData.isPrivate : ${basicData.isPrivate}');
    return Slidable(
      key: UniqueKey(),
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.15,
      secondaryActions: isCustomField
          ? <Widget>[
              IconSlideAction(
                caption: '',
                iconWidget: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    'Edit',
                  ),
                ),
                onTap: () {
                  SetupRoutes.push(context, Routes.ADD_CUSTOM_FIELD,
                      arguments: {
                        'onSave': (BasicData data, int index) {
                          List<BasicData>? customFields =
                              Provider.of<UserPreview>(context, listen: false)
                                  .user()!
                                  .customFields[widget.category.name];
                          if (index > -1) {
                            setState(() {
                              customFields![index] = data;
                            });
                          } else {
                            customFields!.add(data);
                          }
                        },
                        'basicData': basicData,
                        'isEdit': true,
                        'category': widget.category
                      });
                },
              ),
              IconSlideAction(
                caption: '',
                color: ColorConstants.red,
                iconWidget: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    'Delete',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                onTap: () {
                  if (!isCustomField) {
                    updateDefinedFields(
                        BasicData(accountName: basicData.accountName));
                  }
                  List<BasicData>? customFields =
                      Provider.of<UserPreview>(context, listen: false)
                          .user()!
                          .customFields[widget.category.name];

                  var index = customFields!.indexOf(basicData);
                  customFields[index] = BasicData(
                      accountName:
                          customFields[index].accountName! + AtText.IS_DELETED,
                      isPrivate: customFields[index].isPrivate);
                  setState(() {});
                },
              ),
            ]
          : null,
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextFormField(
                key: UniqueKey(),
                autovalidateMode: isCustomField
                    ? basicData.value != ''
                        ? AutovalidateMode.disabled
                        : AutovalidateMode.onUserInteraction
                    : AutovalidateMode.disabled,
                validator: (value) {
                  if (value == null || value == '' && isCustomField) {
                    return 'Please provide value';
                  }
                  return null;
                },
                initialValue: basicData.value,
                onChanged: (String value) {
                  basicData.value = value;
                  if (!isCustomField) {
                    updateDefinedFields(basicData);
                  }
                  _formKey.currentState!.validate();
                },
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    errorStyle: TextStyle(fontSize: 15),
                    border: InputBorder.none,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    )),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
              ),
            ),
            GestureDetector(
              onTap: () {
                showPublicPrivateBottomSheet(
                    onPublicClicked: () {
                      setState(() {
                        basicData.isPrivate = false;
                      });
                    },
                    onPrivateClicked: () {
                      setState(() {
                        basicData.isPrivate = true;
                      });
                    },
                    height: 160);
              },
              child: Icon(
                basicData.isPrivate ? Icons.lock : Icons.public,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget imageField(BasicData basicData) {
    var intList = basicData.value!.cast<int>();
    Uint8List customImage = Uint8List.fromList(intList);

    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          basicData.valueDescription != null
              ? Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Text(basicData.valueDescription!))
              : SizedBox(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            height: 200,
            child: Image.memory(
              customImage,
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }

  bool isAllFieldsPrivate() {
    var userMap =
        User.toJson(Provider.of<UserPreview>(context, listen: false).user());
    List<FieldsEnum> fields = FieldNames().getFieldListEnum(widget.category);

    for (int i = 0; i < fields.length; i++) {
      if (!userMap[fields[i].name].isPrivate) {
        return false;
      }
    }

    List<BasicData>? customFields =
        Provider.of<UserPreview>(context, listen: false)
            .user()!
            .customFields[widget.category.name];

    if (customFields != null) {
      for (var basicData in customFields) {
        if (basicData.accountName != null &&
            basicData.value != null &&
            !basicData.isPrivate) {
          return false;
        }
      }
    }
    return true;
  }

  changeFiledsVisibility(bool isPrivate) {
    var userMap =
        User.toJson(Provider.of<UserPreview>(context, listen: false).user());
    List<FieldsEnum> fields = FieldNames().getFieldListEnum(widget.category);

    List<BasicData>? customFields =
        Provider.of<UserPreview>(context, listen: false)
            .user()!
            .customFields[widget.category.name];

    for (int i = 0; i < fields.length; i++) {
      BasicData basicData = userMap[fields[i].name];
      basicData.isPrivate = isPrivate;
    }

    if (customFields != null) {
      for (var basicData in customFields) {
        basicData.isPrivate = isPrivate;
      }
    }

    setState(() {});
  }

  /// [updateDefinedFields]can be used to either update or delete value
  /// when deleting send [BasicData] with just accountname
  /// when updating send complete [BasicData].
  updateDefinedFields(BasicData basicData) {
    if (basicData.accountName == FieldsEnum.IMAGE.name) {
      Provider.of<UserPreview>(context, listen: false).user()!.image =
          basicData;
    } else if (basicData.accountName == FieldsEnum.LASTNAME.name) {
      Provider.of<UserPreview>(context, listen: false).user()!.lastname =
          basicData;
    } else if (basicData.accountName == FieldsEnum.FIRSTNAME.name) {
      Provider.of<UserPreview>(context, listen: false).user()!.firstname =
          basicData;
    } else if (basicData.accountName == FieldsEnum.PHONE.name) {
      Provider.of<UserPreview>(context, listen: false).user()!.phone =
          basicData;
    } else if (basicData.accountName == FieldsEnum.EMAIL.name) {
      Provider.of<UserPreview>(context, listen: false).user()!.email =
          basicData;
    } else if (basicData.accountName == FieldsEnum.ABOUT.name) {
      Provider.of<UserPreview>(context, listen: false).user()!.about =
          basicData;
    } else if (basicData.accountName == FieldsEnum.LOCATION.name) {
      Provider.of<UserPreview>(context, listen: false).user()!.location =
          basicData;
    } else if (basicData.accountName == FieldsEnum.LOCATIONNICKNAME.name) {
      Provider.of<UserPreview>(context, listen: false)
          .user()!
          .locationNickName = basicData;
    } else if (basicData.accountName == FieldsEnum.PRONOUN.name) {
      Provider.of<UserPreview>(context, listen: false).user()!.pronoun =
          basicData;
    } else if (basicData.accountName == FieldsEnum.TWITTER.name) {
      Provider.of<UserPreview>(context, listen: false).user()!.twitter =
          basicData;
    } else if (basicData.accountName == FieldsEnum.FACEBOOK.name) {
      Provider.of<UserPreview>(context, listen: false).user()!.facebook =
          basicData;
    } else if (basicData.accountName == FieldsEnum.LINKEDIN.name) {
      Provider.of<UserPreview>(context, listen: false).user()!.linkedin =
          basicData;
    } else if (basicData.accountName == FieldsEnum.INSTAGRAM.name) {
      Provider.of<UserPreview>(context, listen: false).user()!.instagram =
          basicData;
    } else if (basicData.accountName == FieldsEnum.YOUTUBE.name) {
      Provider.of<UserPreview>(context, listen: false).user()!.youtube =
          basicData;
    } else if (basicData.accountName == FieldsEnum.TUMBLR.name) {
      Provider.of<UserPreview>(context, listen: false).user()!.tumbler =
          basicData;
    } else if (basicData.accountName == FieldsEnum.MEDIUM.name) {
      Provider.of<UserPreview>(context, listen: false).user()!.medium =
          basicData;
    } else if (basicData.accountName == FieldsEnum.PS4.name) {
      Provider.of<UserPreview>(context, listen: false).user()!.ps4 = basicData;
    } else if (basicData.accountName == FieldsEnum.XBOX.name) {
      Provider.of<UserPreview>(context, listen: false).user()!.xbox = basicData;
    } else if (basicData.accountName == FieldsEnum.STEAM.name) {
      Provider.of<UserPreview>(context, listen: false).user()!.steam =
          basicData;
    } else if (basicData.accountName == FieldsEnum.DISCORD.name) {
      Provider.of<UserPreview>(context, listen: false).user()!.discord =
          basicData;
    }
  }
}
