import 'package:latlong2/latlong.dart';

class OsmLocationModel {
  LatLng? latLng;
  double? zoom, diameter;
  OsmLocationModel(this.latLng, this.zoom, this.diameter);

  OsmLocationModel.fromJson(Map<String, dynamic> json)
      : latLng = json['latLng'],
        diameter = json['diameter'] != 'null' && json['diameter'] != null
            ? double.parse(json['diameter'])
            : null,
        zoom = json['zoom'] != 'null' && json['zoom'] != null
            ? double.parse(json['zoom'])
            : null;
}
