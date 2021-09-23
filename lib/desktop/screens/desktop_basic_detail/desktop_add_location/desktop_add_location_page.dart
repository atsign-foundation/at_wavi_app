import 'dart:io';
import 'package:at_location_flutter/map_content/flutter_map/flutter_map.dart';
import 'package:at_wavi_app/common_components/create_marker.dart';
import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/desktop/widgets/buttons/desktop_icon_label_button.dart';
import 'package:at_wavi_app/desktop/widgets/desktop_button.dart';
import 'package:at_wavi_app/desktop/widgets/desktop_show_hide_radio_button.dart';
import 'package:at_wavi_app/desktop/widgets/textfields/desktop_textfield.dart';
import 'package:at_wavi_app/model/osm_location_model.dart';
import 'package:at_wavi_app/utils/at_enum.dart';
import 'package:at_wavi_app/view_models/user_preview.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import 'desktop_add_location_model.dart';

class DesktopAddLocationPage extends StatefulWidget {
  const DesktopAddLocationPage({Key? key}) : super(key: key);

  @override
  _DesktopAddLocationPageState createState() => _DesktopAddLocationPageState();
}

class _DesktopAddLocationPageState extends State<DesktopAddLocationPage> {
  late DesktopAddLocationModel _model;
  final _locationTextController = TextEditingController();
  final _tagTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final osmLocationModel = OsmLocationModel(
      "Ha Noi",
      10,
      14,
      10,
      latitude: 21.028511,
      longitude: 105.804817,
    );
    final appTheme = AppTheme.of(context);
    return ChangeNotifierProvider(
      create: (BuildContext c) {
        final userPreview = Provider.of<UserPreview>(context);
        _model = DesktopAddLocationModel(userPreview: userPreview);
        return _model;
      },
      child: Container(
        width: 600,
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: appTheme.backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: 400,
                minHeight: 400, 
              ),
              child: AbsorbPointer(
                absorbing: true,
                child: FlutterMap(
                  options: MapOptions(
                    boundsOptions:
                    FitBoundsOptions(padding: EdgeInsets.all(0)),
                    center: osmLocationModel.latLng,
                    zoom: osmLocationModel.zoom ?? 14.0,
                  ),
                  layers: [
                    TileLayerOptions(
                      urlTemplate:
                      'https://api.maptiler.com/maps/streets/{z}/{x}/{y}.png?key=Jr6qaSd6EftaATGRMYaN',
                      subdomains: ['a', 'b', 'c'],
                      minNativeZoom: 2,
                      maxNativeZoom: 18,
                      minZoom: 1,
                      tileProvider: NonCachingNetworkTileProvider(),
                    ),
                    MarkerLayerOptions(markers: [
                      if (osmLocationModel.latLng != null)
                        Marker(
                          width: 40,
                          height: 50,
                          point: osmLocationModel.latLng!,
                          builder: (ctx) => Container(
                              child: createMarker(
                                  diameterOfCircle:
                                  osmLocationModel.diameter ?? 0)),
                        )
                    ])
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Location',
              style: TextStyle(
                fontSize: 16,
                color: appTheme.primaryTextColor,
              ),
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: _locationTextController,
              enabled: false,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: appTheme.primaryTextColor,
              ),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: appTheme.borderColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: appTheme.primaryColor),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: appTheme.borderColor),
                ),
                suffixIcon: GestureDetector(
                  child: Container(
                    width: 80,
                    child: Center(
                      child: Text(
                        'Change',
                        style: TextStyle(
                          color: appTheme.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Add tag',
              style: TextStyle(
                fontSize: 16,
                color: appTheme.primaryTextColor,
              ),
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: _tagTextController,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: appTheme.primaryTextColor,
              ),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: appTheme.borderColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: appTheme.primaryColor),
                ),
              ),
            ),
            SizedBox(height: 24),
            Container(
              alignment: Alignment.centerRight,
              child: DesktopButton(
                title: 'Save',
                width: 180,
                onPressed: _onSaveData,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onSaveData() {
    _model.saveData(context);
  }
}
