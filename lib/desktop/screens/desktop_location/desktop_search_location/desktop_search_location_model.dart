import 'dart:convert';

import 'package:at_wavi_app/model/here_result.dart';
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
    notifyListeners();
    var url;
    // ignore: unnecessary_null_comparison
    if (currentLocation != null) {
      url =
          'https://geocode.search.hereapi.com/v1/geocode?q=${address.replaceAll(RegExp(' '), '+')}&apiKey=${'yRCeKfJDPQDTp11YI1db67J_fww80QP6R3Llckg-REw'}&at=${currentLocation.latitude},${currentLocation.longitude}';
    } else {
      url =
          'https://geocode.search.hereapi.com/v1/geocode?q=${address.replaceAll(RegExp(' '), '+')}&apiKey=${'yRCeKfJDPQDTp11YI1db67J_fww80QP6R3Llckg-REw'}';
    }
    print(url);
    try {
      var response = await http.get(Uri.parse(url));
      var addresses = jsonDecode(response.body);
      print(response.body);
      final result = HereResultList.fromJson(addresses);
      _resultList = result;
      _isSearching = false;
      notifyListeners();
    } catch (e) {
      _isSearching = false;
      notifyListeners();
    }
    // List data = addresses['items'];
    // var share = <LocationModal>[];
    // //// Removed because of nulls safety
    // // for (Map ad in data ?? []) {
    // for (Map ad in data) {
    //   share.add(LocationModal.fromJson(ad));
    // }
    //
    // atLocationSink.add(share);
  }
}
