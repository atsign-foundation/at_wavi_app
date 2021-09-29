import 'package:at_location_flutter/map_content/flutter_map/flutter_map.dart';
import 'package:at_wavi_app/common_components/create_marker.dart';
import 'package:at_wavi_app/desktop/screens/desktop_basic_detail/desktop_select_location/desktop_select_location_page.dart';
import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/desktop/widgets/desktop_button.dart';
import 'package:at_wavi_app/view_models/user_preview.dart';
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

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return ChangeNotifierProvider(
      create: (BuildContext c) {
        final userPreview = Provider.of<UserPreview>(context);
        _model = DesktopAddLocationModel(userPreview: userPreview);
        return _model;
      },
      child: Consumer<DesktopAddLocationModel>(
        builder: (_, model, child) {
          return Container(
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
                    maxHeight: 320,
                    minHeight: 320,
                  ),
                  child: AbsorbPointer(
                    absorbing: true,
                    child: FlutterMap(
                      options: MapOptions(
                        boundsOptions:
                            FitBoundsOptions(padding: EdgeInsets.all(0)),
                        center: model.osmLocationModel!.latLng,
                        zoom: model.osmLocationModel!.zoom ?? 14.0,
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
                          if (model.osmLocationModel!.latLng != null)
                            Marker(
                              width: 40,
                              height: 50,
                              point: model.osmLocationModel!.latLng!,
                              builder: (ctx) => Container(
                                  child: createMarker(
                                      diameterOfCircle:
                                          model.osmLocationModel!.diameter ??
                                              0)),
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
                GestureDetector(
                  onTap: () {
                    openSelectLocation(model.osmLocationModel!.latLng!);
                  },
                  child: Container(
                    height: 48,
                    child: TextFormField(
                      controller: model.locationTextController,
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
                        suffixIcon: InkWell(
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
                Container(
                  height: 48,
                  child: TextFormField(
                    controller: model.tagTextController,
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
                ),
                SizedBox(height: 24),
                Container(
                  alignment: Alignment.centerRight,
                  child: DesktopButton(
                    title: 'Save',
                    width: 180,
                    height: 48,
                    onPressed: _onSaveData,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void openSelectLocation(LatLng latLng) async {
    print('Open location picker');
    final result = await showDialog<String>(
      context: context,
      builder: (BuildContext context) => Dialog(
        backgroundColor: Colors.transparent,
        child: DesktopSelectLocationPage(
          'Ha noi',
          latLng,
          callbackFunction: (location) {
            _model.changeLocation(location);
          },
        ),
      ),
    );
    if (result == 'saved') {}
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (context) => DesktopSelectLocationPage(
    //       'Ha noi',
    //       LatLng(21.028511, 105.804817),
    //     ),
    //   ),
    // );
  }

  Future _onSaveData() async {
    await _model.saveData(context);
  }
}
