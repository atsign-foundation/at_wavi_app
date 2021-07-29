import 'package:at_common_flutter/services/size_config.dart';
import 'package:at_common_flutter/widgets/custom_button.dart';
import 'package:at_location_flutter/at_location_flutter.dart';
import 'package:at_location_flutter/common_components/marker_custom_painter.dart';
import 'package:at_location_flutter/map_content/flutter_map/flutter_map.dart';
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

  @override
  Widget build(BuildContext context) {
    marker = Marker(
      width: 40,
      height: 50,
      point: center,
      builder: (ctx) => Container(
        // color: Colors.red,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              bottom: 25, // height/2 => so, it starts from center
              child: Icon(
                Icons.location_on,
                color: ColorConstants.orange,
                size: 40,
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
              returnPositionTapped: (_latLng, _zoom) {
                print('new latlng $_latLng, newZoom: $_zoom');
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
                height: 200,
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
                                    Text('Double tap to move pointer',
                                        style: CustomTextStyles.customTextStyle(
                                            ColorConstants.black)),
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
                          SizedBox(height: 10.toHeight),
                          Flexible(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: ColorConstants.orange,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                  child: Text(widget.displayName,
                                      style: CustomTextStyles.customTextStyle(
                                          ColorConstants.DARK_GREY)),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20.toHeight),
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
        onTap: () async {},
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
