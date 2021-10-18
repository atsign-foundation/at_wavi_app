import 'dart:convert';

import 'package:latlong2/latlong.dart';

/// [location] & [radius] comes from previous Wavi apps model
/// [zoom], [latitude] & [longitude] are used by wavi.ng to store location values
/// [diameter] is needed for backward compatibility
/// In wavi radius is stored as miles as 2, 5 or 10
class OsmLocationModel {
  // LatLng? latLng;
  double? zoom, radius, latitude, longitude, diameter;
  String? location;
  OsmLocationModel(this.location, this.radius, this.zoom,
      {this.latitude, this.longitude, this.diameter});

  LatLng? get latLng => (latitude == null || longitude == null)
      ? null
      : LatLng(latitude!, longitude!);

  OsmLocationModel.fromJson(Map<String, dynamic> json) {
    location = json['location'];
    getRadius(json);
    if (json['diameter'] != 'null' && json['diameter'] != null) {
      diameter = double.parse((json['diameter']).toString());
    }
    zoom = json['zoom'] != 'null' && json['zoom'] != null
        ? double.parse((json['zoom']).toString())
        : 16;
    latitude = json['latitude'] != 'null' && json['latitude'] != null
        ? double.parse((json['latitude']).toString())
        : null;
    longitude = json['longitude'] != 'null' && json['longitude'] != null
        ? double.parse((json['longitude']).toString())
        : null;
  }

  getRadius(Map<String, dynamic> json) {
    try {
      if (json['radius'] != 'null' && json['radius'] != null) {
        if (!json['radius'].toString().contains('mi')) {
          // to filter previous wavi data that contains mi
          switch (json['radius']) {
            case '2.0':
              radius = 100;
              return;
            case '5.0':
              radius = 200;
              return;
            case '10.0':
              radius = 300;
              return;
            default:
              return radius = 100;
          }
        } else {
          radius = 100;
        }
      } else {
        if (json['diameter'] != 'null' && json['diameter'] != null) {
          radius = double.parse(json['diameter']);
        }
      }
    } catch (e) {
      print('Error in getRadius $e');
      radius = 100;
    }
  }

  toJson() {
    return json.encode({
      'location': location.toString(),
      'radius': radius.toString(),
      // 'latLng': latLng.toString(),
      'diameter': diameter.toString(),
      'zoom': zoom.toString(),
      'latitude': latitude.toString(),
      'longitude': longitude.toString(),
    });
  }
}
