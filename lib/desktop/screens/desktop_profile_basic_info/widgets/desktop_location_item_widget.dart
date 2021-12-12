import 'dart:convert';

import 'package:at_location_flutter/map_content/flutter_map/flutter_map.dart';
import 'package:at_wavi_app/common_components/create_marker.dart';
import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/model/osm_location_model.dart';
import 'package:at_wavi_app/utils/constants.dart';
import 'package:flutter/material.dart';

class DesktopLocationItemWidget extends StatelessWidget {
  final String? title;
  final String? location;

  DesktopLocationItemWidget({
    Key? key,
    this.title,
    this.location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);

    OsmLocationModel? osmLocationModel;
    try {
      osmLocationModel = OsmLocationModel.fromJson(jsonDecode(location ?? "{}"));
    } catch (e) {
      print(e);
    }
    return Container(
      height: 200,
      padding: EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 100,
            child: Text(
              title ?? '',
              style:
                  TextStyle(color: appTheme.secondaryTextColor, fontSize: 16),
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: osmLocationModel != null
                ? AbsorbPointer(
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
                              'https://api.maptiler.com/maps/streets/{z}/{x}/{y}.png?key=${MixedConstants.MAP_KEY}',
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
                                          osmLocationModel!.diameter ?? 0)),
                            )
                        ])
                      ],
                    ),
                  )
                : Container(),
          ),
        ],
      ),
    );
  }
}
