import 'dart:convert';

import 'package:latlong2/latlong.dart';

/// [location] & [radius] comes from previous Wavi apps model
/// [diameter], [zoom], [latitude] & [longitude] are used by wavi.ng to store location values
class OsmLocationModel {
  // LatLng? latLng;
  double? zoom, diameter, latitude, longitude;
  String? location, radius;
  OsmLocationModel(this.location, this.radius, this.zoom, this.diameter,
      {this.latitude, this.longitude});

  LatLng? get latLng => (latitude == null || longitude == null)
      ? null
      : LatLng(latitude!, longitude!);

  OsmLocationModel.fromJson(Map<String, dynamic> json)
      : location = json['location'],
        radius = json['radius'] != 'null' && json['radius'] != null
            ? json['radius']
            : null,
        // latLng = json['latLng'],
        diameter = json['diameter'] != 'null' && json['diameter'] != null
            ? double.parse(json['diameter'])
            : null,
        zoom = json['zoom'] != 'null' && json['zoom'] != null
            ? double.parse(json['zoom'])
            : null,
        latitude = json['latitude'] != 'null' && json['latitude'] != null
            ? double.parse(json['latitude'])
            : null,
        longitude = json['longitude'] != 'null' && json['longitude'] != null
            ? double.parse(json['longitude'])
            : null;

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
