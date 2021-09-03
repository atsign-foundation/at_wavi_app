import 'package:at_common_flutter/widgets/custom_button.dart';
import 'package:at_wavi_app/model/user.dart';
import 'package:at_wavi_app/services/field_order_service.dart';
import 'package:at_wavi_app/utils/at_enum.dart';
import 'package:at_wavi_app/utils/at_key_constants.dart';
import 'package:at_wavi_app/utils/colors.dart';
import 'package:at_wavi_app/utils/text_styles.dart';
import 'package:at_wavi_app/view_models/theme_view_model.dart';
import 'package:at_wavi_app/view_models/user_preview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReorderFields extends StatefulWidget {
  final AtCategory category;
  final Function onSave;

  ReorderFields({required this.category, required this.onSave});

  @override
  _ReorderFieldsState createState() => _ReorderFieldsState();
}

class _ReorderFieldsState extends State<ReorderFields> {
  var fields = <String>[];
  ThemeData? _themeData;

  @override
  void initState() {
    _getThemeData();
    if (FieldOrderService().previewOrders[widget.category.name] != null) {
      fields = [...FieldOrderService().previewOrders[widget.category.name]!];
    }
    super.initState();
  }

  _getThemeData() async {
    _themeData =
        await Provider.of<ThemeProvider>(context, listen: false).getTheme();

    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_themeData == null) {
      return CircularProgressIndicator();
    }

    return Container(
      color: ColorConstants.white,
      child: SafeArea(
        child: Scaffold(
          bottomNavigationBar: CustomButton(
            width: double.infinity,
            height: 60,
            buttonText: 'Save',
            fontColor: ColorConstants.white,
            borderRadius: 0,
            onPressed: _saveFieldOrder,
          ),
          body: Column(
            children: [
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {},
                      child: Row(
                        children: [
                          SizedBox(width: 5),
                          Text(
                            'Reorder',
                            style: TextStyles.boldText(_themeData!.primaryColor,
                                size: 16),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyles.lightText(_themeData!.primaryColor,
                            size: 14),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 30),
              Container(
                height: 500,
                child: ReorderableListView(
                  children: [
                    ...getRowTitle(),
                  ],
                  onReorder: (int oldIndex, int newIndex) {
                    setState(() {
                      if (oldIndex < newIndex) {
                        newIndex -= 1;
                      }
                      final String item = fields.removeAt(oldIndex);
                      fields.insert(newIndex, item);
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

  List<Widget> getRowTitle() {
    var reorderList = <ListTile>[];

    for (int index = 0; index < fields.length; index++) {
      reorderList.add(ListTile(
        contentPadding: EdgeInsets.all(0),
        key: Key('$index'),
        title: reorderTitle(fields[index]),
      ));
    }
    return reorderList;
  }

  Widget reorderTitle(String field) {
    var tile = SizedBox();
    BasicData basicData = BasicData();

    var userMap =
        User.toJson(Provider.of<UserPreview>(context, listen: false).user());
    List<BasicData>? customFields =
        Provider.of<UserPreview>(context, listen: false)
            .user()!
            .customFields[widget.category.name];

    if (userMap.containsKey(field)) {
      basicData = userMap[field];
    } else {
      var index = customFields!.indexWhere((el) => el.accountName == field);
      if (index != -1) basicData = customFields[index];
    }

    if (basicData.value == null) {
      basicData.value = '';
    }

    if (basicData.accountName != null &&
        basicData.value != null &&
        !basicData.accountName!.contains(AtText.IS_DELETED)) {
      return fieldCard(basicData);
    }
    return tile;
  }

  Widget fieldCard(BasicData basicData) {
    Widget card = SizedBox();

    card = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  basicData.accountName!,
                  style: TextStyles.lightText(
                      _themeData!.primaryColor.withOpacity(0.5),
                      size: 16),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: basicData.type == CustomContentType.Image.name
                    ? Image.memory(basicData.value)
                    : Text(
                        basicData.value!,
                        style: TextStyles.lightText(_themeData!.primaryColor,
                            size: 18),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
              ),
              Divider()
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: Icon(
            Icons.reorder,
            color: _themeData!.primaryColor,
          ),
        )
      ],
    );

    return card;
  }

  _saveFieldOrder() {
    FieldOrderService().updateField(widget.category, fields);
    Navigator.of(context).pop();
    widget.onSave();
  }
}
