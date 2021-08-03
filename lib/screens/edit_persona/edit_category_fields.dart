import 'package:at_wavi_app/common_components/add_custom_content_button.dart';
import 'package:at_wavi_app/common_components/header.dart';
import 'package:at_wavi_app/common_components/public_private_bottomsheet.dart';
import 'package:at_wavi_app/model/user.dart';
import 'package:at_wavi_app/routes/route_names.dart';
import 'package:at_wavi_app/routes/routes.dart';
import 'package:at_wavi_app/utils/at_enum.dart';
import 'package:at_wavi_app/utils/colors.dart';
import 'package:at_wavi_app/utils/field_names.dart';
import 'package:at_wavi_app/utils/text_styles.dart';
import 'package:at_wavi_app/view_models/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:at_common_flutter/at_common_flutter.dart';
import 'package:at_wavi_app/services/size_config.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class EditCategoryFields extends StatefulWidget {
  final AtCategory category;
  final String filedHeading;
  EditCategoryFields({required this.category, required this.filedHeading});

  @override
  _EditCategoryFieldsState createState() => _EditCategoryFieldsState();
}

class _EditCategoryFieldsState extends State<EditCategoryFields> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          child: Column(
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
                        Navigator.of(context).pop();
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
                            onPublicClicked: () {},
                            onPrivateClicked: () {},
                            height: 160);
                      },
                      child: Icon(Icons.public),
                    )
                  ],
                ),
              ),
              SizedBox(height: 35),
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: getAllInputFields(),
                ),
              )),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: AddCustomContentButton(
                  text: 'Add custom content',
                  onTap: () {
                    SetupRoutes.push(context, Routes.CREATE_CUSTOM_LOCATION);
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
    var userMap = User.toJson(UserProvider().user!);
    List<String> fields = FieldNames().getFieldList(widget.category);

    for (var field in userMap.entries) {
      if (field.key != null &&
          fields.contains(field.key) &&
          field.value != null &&
          field.value.value != null) {
        var widget = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 1),
              child: Text(
                field.key,
                style: TextStyles.lightText(
                    ColorConstants.black.withOpacity(0.5),
                    size: 16),
              ),
            ),
            inputField(field.value.value),
            Divider(thickness: 1, height: 1),
            SizedBox(height: 20)
          ],
        );

        definedFieldsWidgets.add(widget);
      }
    }
    return definedFieldsWidgets;
  }

  List<Widget> getCustomInputFields() {
    var customFieldsWidgets = <Widget>[];
    List<BasicData>? customFields =
        UserProvider().user!.customFields[widget.category.name];

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
          inputField(basicData.value),
          Divider(thickness: 1, height: 1),
          SizedBox(height: 20)
        ],
      );
    }
    return SizedBox();
  }

  Widget inputField(String value) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.15,
      secondaryActions: <Widget>[
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
          onTap: () {},
        ),
      ],
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: CustomInputField(
                height: 60,
                inputFieldColor: Colors.white,
                hintText: '',
                initialValue: value,
                value: (String s) {
                  print('text : $s');
                },
              ),
            ),
            GestureDetector(
              onTap: () {
                showPublicPrivateBottomSheet(
                    onPublicClicked: () {},
                    onPrivateClicked: () {},
                    height: 160);
              },
              child: Icon(Icons.public),
            ),
          ],
        ),
      ),
    );
  }
}
