import 'dart:convert';

import 'package:at_wavi_app/desktop/utils/utils.dart';
import 'package:at_wavi_app/model/osm_location_model.dart';
import 'package:at_wavi_app/model/user.dart';
import 'package:at_wavi_app/services/field_order_service.dart';
import 'package:at_wavi_app/utils/at_enum.dart';
import 'package:at_wavi_app/view_models/user_preview.dart';
import 'package:flutter/cupertino.dart';

class DesktopAddLocationModel extends ChangeNotifier {
  final UserPreview userPreview;

  CustomContentType _fieldType = CustomContentType.Text;

  CustomContentType get fieldType => _fieldType;

  OsmLocationModel? _osmLocationModel;

  OsmLocationModel? get osmLocationModel => _osmLocationModel;

  BasicData? _data;
  BasicData? originBasicData;

  BasicData? get data => _data;
  late bool _isPrivate;

  var tagTextController = TextEditingController();

  bool _isEditing = false;
  bool _isCustomField = false;
  BasicData? _location;
  BasicData? _locationNickname;

  DesktopAddLocationModel({
    required this.userPreview,
    required bool isEditing,
    required bool isCustomField,
    BasicData? location,
    BasicData? locationNickname,
  }) {
    _data = userPreview.user()!.location;
    _isPrivate = userPreview.user()!.location.isPrivate;

    _isEditing = isEditing;
    _isCustomField = isCustomField;
    _location = location;
    _locationNickname = locationNickname;

    if (_isEditing) {
      if (_isCustomField) {
        originBasicData = location;
        tagTextController.text = location?.accountName ?? '';
        try {
          _osmLocationModel = OsmLocationModel.fromJson(
              jsonDecode((location?.value as String?) ?? "{}"));
        } catch (e) {}
      } else {
        tagTextController.text = locationNickname?.value?.toString() ?? '';
        try {
          _osmLocationModel = OsmLocationModel.fromJson(
              jsonDecode((location?.value as String?) ?? "{}"));
        } catch (e) {}
      }
    } else {}
  }

  void changeField(CustomContentType fieldType) {
    _fieldType = fieldType;
    notifyListeners();
  }

  void changeLocation(OsmLocationModel osmLocationModel) {
    _osmLocationModel = osmLocationModel;
    notifyListeners();
  }

  Future saveData(BuildContext context) async {
    if (osmLocationModel != null) {
      var basicData = BasicData(
        accountName: tagTextController.text,
        value: OsmLocationModel(
          tagTextController.text,
          osmLocationModel!.radius,
          osmLocationModel!.zoom,
          latitude: osmLocationModel!.latitude,
          longitude: osmLocationModel!.longitude,
          diameter: osmLocationModel!.diameter,
        ).toJson(),
        type: CustomContentType.Location.name,
      );

      if (_isCustomField) {
        if (_isEditing) {
          List<BasicData>? customFields =
              userPreview.user()!.customFields[AtCategory.LOCATION.name];

          int index = customFields?.indexWhere((element) =>
                  element.accountName == originBasicData?.accountName) ??
              -1;
          if (index >= 0) {
            customFields![index] = basicData;
          }

          userPreview.user()?.customFields[AtCategory.LOCATION.name] =
              customFields ?? [];
          FieldOrderService().updateSingleField(
            AtCategory.LOCATION,
            originBasicData?.accountName ?? '',
            basicData.accountName ?? '',
          );
        } else {
          List<BasicData>? customFields =
              userPreview.user()!.customFields[AtCategory.LOCATION.name];
          customFields!.add(basicData);

          userPreview.user()?.customFields[AtCategory.LOCATION.name] =
              customFields;

          FieldOrderService()
              .addNewField(AtCategory.LOCATION, basicData.accountName!);
        }
      } else {
        userPreview.user()?.location = BasicData(
          value: OsmLocationModel(
            tagTextController.text,
            osmLocationModel!.radius,
            osmLocationModel!.zoom,
            latitude: osmLocationModel!.latitude,
            longitude: osmLocationModel!.longitude,
            diameter: osmLocationModel!.diameter,
          ).toJson(),
        );
        userPreview.user()?.locationNickName = BasicData(
          value: tagTextController.text,
        );
      }

      Navigator.of(context).pop('saved');
    } else {
      Navigator.of(context).pop();
    }
  }
}
