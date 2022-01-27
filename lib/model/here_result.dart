import 'dart:convert';

class HereResultList {
  HereResultList({
    this.items,
  });

  List<HereResult>? items;

  factory HereResultList.fromJson(Map<String, dynamic> json) => HereResultList(
        items: List<HereResult>.from(
            json["items"].map((x) => HereResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from((items ?? []).map((x) => x.toJson())),
      };
}

class HereResult {
  HereResult({
    this.title,
    this.id,
    this.resultType,
    this.administrativeAreaType,
    this.address,
    this.position,
    this.mapView,
  });

  String? title;
  String? id;
  String? resultType;
  String? administrativeAreaType;
  Address? address;
  Position? position;
  MapView? mapView;

  factory HereResult.fromJson(Map<String, dynamic> json) => HereResult(
        title: json["title"],
        id: json["id"],
        resultType: json["resultType"],
        administrativeAreaType: json["administrativeAreaType"],
        address: Address.fromJson(json["address"]),
        position: Position.fromJson(json["position"]),
        mapView: MapView.fromJson(json["mapView"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "id": id,
        "resultType": resultType,
        "administrativeAreaType": administrativeAreaType,
        "address": address?.toJson(),
        "position": position?.toJson(),
        "mapView": mapView?.toJson(),
      };
}

class Address {
  Address({
    this.label,
    this.countryCode,
    this.countryName,
    this.stateCode,
    this.state,
    this.countyCode,
    this.county,
  });

  String? label;
  String? countryCode;
  String? countryName;
  String? stateCode;
  String? state;
  String? countyCode;
  String? county;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        label: json["label"],
        countryCode: json["countryCode"],
        countryName: json["countryName"],
        stateCode: json["stateCode"],
        state: json["state"],
        countyCode: json["countyCode"],
        county: json["county"],
      );

  Map<String, dynamic> toJson() => {
        "label": label,
        "countryCode": countryCode,
        "countryName": countryName,
        "stateCode": stateCode,
        "state": state,
        "countyCode": countyCode,
        "county": county,
      };
}

class MapView {
  MapView({
    this.west,
    this.south,
    this.east,
    this.north,
  });

  double? west;
  double? south;
  double? east;
  double? north;

  factory MapView.fromJson(Map<String, dynamic> json) => MapView(
        west: json["west"].toDouble(),
        south: json["south"].toDouble(),
        east: json["east"].toDouble(),
        north: json["north"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "west": west,
        "south": south,
        "east": east,
        "north": north,
      };
}

class Position {
  Position({
    this.lat,
    this.lng,
  });

  double? lat;
  double? lng;

  factory Position.fromJson(Map<String, dynamic> json) => Position(
        lat: json["lat"].toDouble(),
        lng: json["lng"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
      };
}

class FieldScore {
  FieldScore({
    this.county,
  });

  double? county;

  factory FieldScore.fromJson(Map<String, dynamic> json) => FieldScore(
        county: json["county"],
      );

  Map<String, dynamic> toJson() => {
        "county": county,
      };
}
