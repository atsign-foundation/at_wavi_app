import 'package:at_common_flutter/services/size_config.dart';
import 'package:at_common_flutter/widgets/custom_button.dart';
import 'package:at_location_flutter/at_location_flutter.dart';
import 'package:at_location_flutter/common_components/circle_marker_painter.dart';
import 'package:at_location_flutter/common_components/marker_custom_painter.dart';
import 'package:at_location_flutter/map_content/flutter_map/flutter_map.dart';
import 'package:at_wavi_app/model/osm_location_model.dart';
import 'package:at_wavi_app/screens/location/location_widget.dart';
import 'package:at_wavi_app/utils/colors.dart';
import 'package:at_wavi_app/utils/constants.dart';
import 'package:at_wavi_app/utils/text_styles.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:latlong2/latlong.dart';

class SelectedLocation extends StatefulWidget {
  final LatLng point;
  final String displayName;
  SelectedLocation(this.displayName, this.point);
  @override
  _SelectedLocationState createState() => _SelectedLocationState();
}

class _SelectedLocationState extends State<SelectedLocation> {
  /// Constants for marker and circle
  late double heightOfMarker = 50,
      widthOfMarker = 40,
      diameterOfCircle = 100,
      bottomOfCircle,
      leftOfCircle; // widthOfMarker and size of icon is same

  var mapController = MapController();
  late Marker marker;
  late LatLng center;
  late bool _absorbDoubleTapPointer;
  late double zoom;

  @override
  initState() {
    _absorbDoubleTapPointer = false;
    center = widget.point;
    zoom = 16;
    super.initState();
  }

  calculateMarkerDimensions() {
    /// bottomOfCircle = (((bottom of icon + (size of icon/2))*2 - height of circle)) / 2
    bottomOfCircle = ((((heightOfMarker / 2) + (widthOfMarker / 2)) * 2 -
            diameterOfCircle)) /
        2;

    /// leftOfCircle = (size of icon - width of circle)/2
    leftOfCircle = (widthOfMarker - diameterOfCircle) / 2;
  }

  @override
  Widget build(BuildContext context) {
    calculateMarkerDimensions();
    marker = Marker(
      width: widthOfMarker,
      height: heightOfMarker,
      point: center,
      builder: (ctx) => Container(
        // color: Colors.red,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              bottom:
                  heightOfMarker / 2, // height/2 => so, it starts from center
              child: Icon(
                Icons.location_on,
                color: ColorConstants.orange,
                size: widthOfMarker, // same as width of marker
              ),
            ),
            Positioned(
              // 25 + 20 (bottom + size/2) for center
              bottom:
                  bottomOfCircle, // ((25 + (20))*2 - 200) => ((bottom of icon + (size of icon/2))*2 - heightof circle)
              left:
                  leftOfCircle, // (40-200)/2 => (size of icon - width of circle)/2
              child: SizedBox(
                width: diameterOfCircle,
                height: diameterOfCircle,
                child: CustomPaint(
                  painter: CircleMarkerPainter(
                      color: Color(0xFFF47B5D).withOpacity(0.2),
                      paintingStyle: PaintingStyle.fill),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    return SafeArea(
      child: Scaffold(
        bottomSheet: _bottomSheet(),
        body: Stack(
          children: <Widget>[
            FlutterMap(
              mapController: mapController,
              returnPositionTapped: (_latLng, _zoom) {
                setState(() {
                  if (_absorbDoubleTapPointer) {
                    center = _latLng ?? LatLng(0, 0);
                  }
                  zoom = _zoom ?? 16;
                });
              },
              absorbDoubleTapPointer: _absorbDoubleTapPointer,
              options: MapOptions(
                boundsOptions: FitBoundsOptions(padding: EdgeInsets.all(0)),
                center: center,
                zoom: zoom,
              ),
              layers: [
                TileLayerOptions(
                  urlTemplate:
                      'https://api.maptiler.com/maps/streets/{z}/{x}/{y}.png?key=${MixedConstants.MAP_KEY}',
                  subdomains: ['a', 'b', 'c'],
                  minNativeZoom: 2,
                  maxNativeZoom: 18,
                  minZoom: 1,
                  tileProvider: NonCachingNetworkTileProvider(),
                ),
                MarkerLayerOptions(markers: [marker])
              ],
            ),
            Positioned(
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0), //(x,y)
                      blurRadius: 10.0,
                    ),
                  ],
                ),
                padding: EdgeInsets.fromLTRB(
                    10.toWidth, 20.toHeight, 10.toHeight, 0),
                height: 280,
                width: SizeConfig().screenWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: <Widget>[
                              Checkbox(
                                fillColor: MaterialStateProperty.all<Color>(
                                    ColorConstants.black),
                                value: _absorbDoubleTapPointer,
                                tristate: false,
                                onChanged: (value) async {
                                  setState(() {
                                    _absorbDoubleTapPointer = value!;
                                  });
                                },
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text('Enable double tap to move pointer',
                                        style: CustomTextStyles.customTextStyle(
                                            ColorConstants.DARK_GREY)),
                                    (_absorbDoubleTapPointer)
                                        ? Flexible(
                                            child: Text(
                                                '(Double tap zoom is disabled)',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: CustomTextStyles
                                                    .customTextStyle(
                                                        ColorConstants.RED,
                                                        size: 12)),
                                          )
                                        : SizedBox()
                                  ],
                                ),
                              )
                            ],
                          ),
                          // SizedBox(height: 10.toHeight),
                          Slider(
                            activeColor: ColorConstants.black,
                            inactiveColor: ColorConstants.LIGHT_GREY,
                            value: diameterOfCircle,
                            min: 100,
                            max: 400,
                            divisions: 4,
                            label: 'Adjust radius',
                            onChanged: (double newValue) {
                              setState(() {
                                diameterOfCircle = newValue;
                              });
                            },
                          ),
                          SizedBox(height: 10.toHeight),
                          Flexible(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: ColorConstants.black,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                  child: Text(widget.displayName,
                                      style: CustomTextStyles.customTextStyle(
                                          ColorConstants.black)),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20.toHeight),
                          Flexible(
                            child: RichText(
                              text: TextSpan(
                                text: 'NOTE: ',
                                style: CustomTextStyles.customTextStyle(
                                    ColorConstants.black,
                                    size: 12),
                                children: [
                                  TextSpan(
                                    text:
                                        'The view you select (Position of the marker, zoom level and radius of the circle), will be shown to other users.',
                                    style: CustomTextStyles.customTextStyle(
                                        ColorConstants.DARK_GREY,
                                        size: 12),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _bottomSheet() {
    return Row(
      children: [
        _bottomSheetButton('Cancel'),
        _bottomSheetButton('Confirm', isDark: true),
      ],
    );
  }

  Widget _bottomSheetButton(String _text, {bool isDark = false}) {
    return Expanded(
      child: InkWell(
        onTap: () async {
          if (_text == 'Cancel') {
            if (zoom - 1 != 0) {
              zoom = zoom - 1;
            }

            mapController.move(center, zoom);
          }

          if (_text == 'Confirm') {
            LocationWidgetData()
                .update(OsmLocationModel(center, zoom, diameterOfCircle));

            Navigator.of(context).pop();
            Navigator.of(context).pop();
          }
        },
        child: Container(
          height: 80.toHeight,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: isDark ? ColorConstants.black : ColorConstants.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 1.0),
                  blurRadius: 3.0,
                ),
              ]),
          child: Text(
            _text,
            style: isDark
                ? CustomTextStyles.customTextStyle(ColorConstants.white,
                    size: 18)
                : CustomTextStyles.customTextStyle(ColorConstants.black,
                    size: 18),
          ),
        ),
      ),
    );
  }
}
