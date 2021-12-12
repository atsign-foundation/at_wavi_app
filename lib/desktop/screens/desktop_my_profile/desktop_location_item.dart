import 'package:at_location_flutter/map_content/flutter_map/flutter_map.dart';
import 'package:at_wavi_app/common_components/create_marker.dart';
import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/model/user.dart';
import 'package:at_wavi_app/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:latlong2/latlong.dart';

class DesktopLocationItem extends StatelessWidget {
  BasicData data;
  LatLng latLng;

  DesktopLocationItem({
    required this.data,
    required this.latLng,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 110,
            child: Text(
              data.accountName ?? '',
              style: TextStyle(
                  fontSize: 12,
                  color: appTheme.secondaryTextColor,
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
                    boundsOptions: FitBoundsOptions(padding: EdgeInsets.all(0)),
                    center: latLng,
                    zoom: 14.0,
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
                    MarkerLayerOptions(
                      markers: [
                        Marker(
                          width: 40,
                          height: 50,
                          point: latLng,
                          builder: (ctx) => Container(
                            child: createMarker(diameterOfCircle: 0),
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
  }
}
