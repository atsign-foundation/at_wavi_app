import 'dart:convert';

import 'package:at_wavi_app/model/here_result.dart';
import 'package:at_wavi_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

class DesktopSearchLocationModel extends ChangeNotifier {
  bool _isSearching = false;

  bool get isSearching => _isSearching;

  HereResultList? _resultList;

  List<HereResult> get resultList => _resultList?.items ?? [];

  void getAddressLatLng(String address, LatLng? currentLocation) async {
    _isSearching = true;
    _resultList = null;
    notifyListeners();
    if (address.isEmpty) {
      _isSearching = false;
      notifyListeners();
    }
    var url;
    // ignore: unnecessary_null_comparison
    if (currentLocation != null) {
      url =
          'https://geocode.search.hereapi.com/v1/geocode?q=${address.replaceAll(RegExp(' '), '+')}&apiKey=${MixedConstants.API_KEY}&at=${currentLocation.latitude},${currentLocation.longitude}';
    } else {
      url =
          'https://geocode.search.hereapi.com/v1/geocode?q=${address.replaceAll(RegExp(' '), '+')}&apiKey=${MixedConstants.API_KEY}';
    }
    print(url);
    try {
      var response = await http
          .get(Uri.parse(url), headers: {'Content-Type': 'application/json'});
      var addresses = jsonDecode(utf8.decode(response.bodyBytes));
      print(response.body);
      final result = HereResultList.fromJson(addresses);
      _resultList = result;
      _isSearching = false;
      notifyListeners();
    } catch (e) {
      _isSearching = false;
      notifyListeners();
    }
  }
}
