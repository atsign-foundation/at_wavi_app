import 'package:at_location_flutter/map_content/flutter_map/flutter_map.dart';
import 'package:at_wavi_app/common_components/create_marker.dart';
import 'package:at_wavi_app/desktop/screens/desktop_main/desktop_details/desktop_location/desktop_location_model.dart';
import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/desktop/utils/dialog_utils.dart';
import 'package:at_wavi_app/desktop/utils/strings.dart';
import 'package:at_wavi_app/desktop/widgets/desktop_button.dart';
import 'package:at_wavi_app/desktop/widgets/desktop_visibility_detector_widget.dart';
import 'package:at_wavi_app/model/osm_location_model.dart';
import 'package:at_wavi_app/utils/at_enum.dart';
import 'package:at_wavi_app/utils/colors.dart';
import 'package:at_wavi_app/utils/constants.dart';
import 'package:at_wavi_app/view_models/user_preview.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

class DesktopLocationPage extends StatefulWidget {
  DesktopLocationPage({Key? key}) : super(key: key);

  var _desktopLocationPageState = _DesktopLocationPageState();

  @override
  _DesktopLocationPageState createState() =>
      this._desktopLocationPageState = new _DesktopLocationPageState();

  Future addLocation() async {
    await _desktopLocationPageState.addLocation();
  }
}

class _DesktopLocationPageState extends State<DesktopLocationPage>
    with AutomaticKeepAliveClientMixin<DesktopLocationPage> {
  late DesktopLocationModel _model;

  @override
  bool get wantKeepAlive => true;

  Future addLocation() async {
    _model.addField();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return DesktopVisibilityDetectorWidget(
      keyScreen: MixedConstants.LOCATION_KEY,
      child: ChangeNotifierProvider(
        create: (BuildContext c) {
          final userPreview = Provider.of<UserPreview>(context);
          _model = DesktopLocationModel(userPreview: userPreview);
          return _model;
        },
        child: Consumer<DesktopLocationModel>(
          builder: (_, model, child) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: model.fields.length == 0
                            ? Container()
                            : Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                decoration: BoxDecoration(
                                  color: ColorConstants.LIGHT_GREY,
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.symmetric(vertical: 8),
                                  itemCount: model.fields.length,
                                  itemBuilder: (context, index) {
                                    if (model.fields[index].value
                                        is OsmLocationModel) {
                                      var latLng = LatLng(
                                          model.fields[index].value.latitude,
                                          model.fields[index].value.longitude);
                                      return Container(
                                        padding: EdgeInsets.all(16),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 110,
                                              child: Text(
                                                model.fields[index]
                                                        .accountName ??
                                                    '',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: appTheme
                                                        .secondaryTextColor,
                                                    fontFamily: 'Inter'),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 16,
                                            ),
                                            Expanded(
                                              child: ConstrainedBox(
                                                constraints: BoxConstraints(
                                                  maxHeight: 320,
                                                  minHeight: 320,
                                                ),
                                                child: AbsorbPointer(
                                                  absorbing: true,
                                                  child: FlutterMap(
                                                    options: MapOptions(
                                                      boundsOptions:
                                                          FitBoundsOptions(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(0)),
                                                      center: latLng,
                                                      zoom: 14.0,
                                                    ),
                                                    layers: [
                                                      TileLayerOptions(
                                                        urlTemplate:
                                                            'https://api.maptiler.com/maps/streets/{z}/{x}/{y}.png?key=Jr6qaSd6EftaATGRMYaN',
                                                        subdomains: [
                                                          'a',
                                                          'b',
                                                          'c'
                                                        ],
                                                        minNativeZoom: 2,
                                                        maxNativeZoom: 18,
                                                        minZoom: 1,
                                                        tileProvider:
                                                            NonCachingNetworkTileProvider(),
                                                      ),
                                                      MarkerLayerOptions(
                                                        markers: [
                                                          Marker(
                                                            width: 40,
                                                            height: 50,
                                                            point: latLng,
                                                            builder: (ctx) =>
                                                                Container(
                                                              child: createMarker(
                                                                  diameterOfCircle:
                                                                      0),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    } else {
                                      return Container();
                                    }
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      child: Divider(
                                        height: 1,
                                        color: appTheme.borderColor,
                                      ),
                                    );
                                  },
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                model.fields.length == 0
                    ? Container()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          DesktopButton(
                            title: Strings.desktop_reorder,
                            height: 48,
                            backgroundColor: appTheme.backgroundColor,
                            borderColor: appTheme.primaryTextColor,
                            titleColor: appTheme.primaryTextColor,
                            onPressed: () async {
                              await showReOderFieldsPopUp(
                                context,
                                AtCategory.LOCATION,
                                () {
                                  /// Update Fields after reorder
                                  _model.fetchBasicData();
                                },
                              );
                            },
                          ),
                        ],
                      ),
              ],
            );
          },
        ),
      ),
    );
  }
}
