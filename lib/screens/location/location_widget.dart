import 'dart:async';
import 'dart:convert';
import 'package:at_settings/routes/routes.dart';
import 'package:at_settings/services/at_error_dialog.dart';
import 'package:at_wavi_app/model/user.dart';
import 'package:at_wavi_app/utils/at_enum.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:at_settings/services/at_services.dart';
import 'package:at_utils/at_logger.dart';

class LocationWidget extends StatefulWidget {
  final isEdit;

  LocationWidget({Key? key, this.isEdit}) : super(key: key);
  @override
  _LocationWidgetState createState() => _LocationWidgetState(isEdit: isEdit);
}

class _LocationWidgetState extends State<LocationWidget> {
  AtSignLogger _logger = AtSignLogger('AtMe LocationWidget');
  GoogleMapController googleController;
  final isEdit;
  bool locationEnabled;
  bool _isLoading = false;
  User localUser;
  StateContainerState container;
  bool isLocationLabel = false;
  bool isLocation = false;
  bool isDisplayMap = false;
  bool isShowRadiusOverlay = false;
  static List<String> radiusItems = ['2 mi', '5 mi', '10 mi'];

  static List<double> radiusValues = [
    2 * 1609.344,
    5 * 1609.344,
    10 * 1609.344
  ];
  var radioSelected = radiusValues[0];
  var _radiusSelected = radiusItems[0];
  LatLng _userLocation;
  // LatLng _markerLocation;
  TextEditingController locationController = TextEditingController();
  TextEditingController locationNickNameController = TextEditingController();

  Set<Circle> circles;
  CameraPosition initialCameraPosition;
  double radiusValue = 2 * 1609.344;
  double _zoom = 12.5;

  _LocationWidgetState({this.isEdit});

  _checkForExistingData() async {
    if (localUser.location.value != null && localUser.location.value != '') {
      var locationJson = jsonDecode(localUser.location.value);
      if (_userLocation == null) {
        String location = locationJson[LocationJson.LOCATION.name];
        locationController.text = location;
        await _setUserLocationFromText(location, isEdit: true);
      }
      await _setLocationFromCoordinates(
          Coordinates(_userLocation.latitude, _userLocation.longitude),
          isEdit: true);
      if (locationJson[LocationJson.RADIUS.name] != null) {
        _radiusSelected = locationJson[LocationJson.RADIUS.name];
      }
    }
    if (localUser.locationNickName.value != null) {
      locationNickNameController.text = localUser.locationNickName.value;
    }
  }

  /// saves [userLocation] as location details for user
  void _saveLocationForUser(String userLocation) {
    locationController.text = userLocation;
    var userLocationJson = {};
    String value;
    if (userLocation.isEmpty) {
      value = userLocation;
    } else {
      userLocationJson[LocationJson.LOCATION.name] = userLocation;
      userLocationJson[LocationJson.RADIUS.name] = _radiusSelected;
      value = jsonEncode(userLocationJson);
    }

    container.set(FieldsEnum.LOCATION.name, value);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    container = StateContainer.of(context);
    localUser = container.user;
    _checkForExistingData();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if (isEdit == null) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: AppBar(
            centerTitle: true,
            title: Text(
              'Add your location',
              style: TextStyle(fontFamily: AtFont.boldFamily),
            ),
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(30))),
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(24.0, 5.0, 24.0, 0.0),
                    child: Column(
                      children: <Widget>[
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              style: TextStyle(
                                  color: AtTheme.themecolor,
                                  fontSize: AtFont.subHeading),
                              children: [
                                TextSpan(text: AtText.HEADER),
                                TextSpan(
                                    text: AtText.HEADER_SUB,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold))
                              ]),
                        ),
                        SizedBox(
                          height: 30,
                        )
                      ],
                    ),
                  ),
                  _getLocationForm(),
                  if (_isLoading)
                    Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.black,
                        strokeWidth: 2,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(AtTheme.themecolor),
                      ),
                    ),
                  if (isDisplayMap) _getMap()
                ],
              ),
            ),
            Container(
              width: 250,
              child: MaterialButton(
                color: AtTheme.themecolor,
                padding: EdgeInsets.all(7.0),
                elevation: 5.0,
                onPressed: () {
                  Navigator.pushNamed(context, Routes.SOCIAL);
                },
                child: Text(
                  AtText.BUTTON_SOCIAL,
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: AtTheme.buttonTextColor),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50.0))),
              ),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      );
    }
    return Column(
      children: <Widget>[
        _getLocationForm(),
        if (_isLoading)
          Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.black,
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(AtTheme.themecolor),
            ),
          ),
        if (isDisplayMap) _getMap()
      ],
    );
  }

  _getLocationForm() {
    var locationField = container.get(FieldsEnum.LOCATION.name);
    return Container(
      padding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 0.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                flex: 8,
                child: TextFormField(
                  textCapitalization: TextCapitalization.words,
                  controller: locationNickNameController,
                  onChanged: (value) {
                    setState(() {
                      container.set(FieldsEnum.LOCATIONNICKNAME.name,
                          locationNickNameController.text);
                    });
                  },
                  decoration: InputDecoration(
                      hintText: FieldsEnum.LOCATIONNICKNAME.hintText,
                      labelText: FieldsEnum.LOCATIONNICKNAME.label,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: AtTheme.borderColor)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AtTheme.borderColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AtTheme.borderColor),
                      )),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                ),
              ),
              Switch(
                value: localUser.allPrivate == true
                    ? true
                    : (localUser.locationNickName?.isPrivate ?? false),
                onChanged: (value) {
                  setState(() {
                    isLocationLabel = value;
                    container.setPrivacy(
                        FieldsEnum.LOCATIONNICKNAME.name, isLocationLabel);
                  });
                },
                inactiveThumbColor: AtTheme.inactiveThumbColor,
                inactiveTrackColor: AtTheme.inactiveTrackColor,
                activeTrackColor: AtTheme.activeTrackColor,
                activeColor: AtTheme.activeColor,
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 8,
                child: TextFormField(
                  controller: locationController,
                  onFieldSubmitted: (value) async {
                    if (value.isNotEmpty) {
                      _isLoading = true;
                      setState(() {});
                      await _setUserLocationFromText(value);
                    } else {
                      isDisplayMap = false;
                    }
                    if ((localUser.location.value != null ||
                            localUser.location.value != '') &&
                        value.isEmpty) {
                      _saveLocationForUser(value);
                    }
                    setState(() {});
                  },
                  decoration: InputDecoration(
                      hintText: FieldsEnum.LOCATION.hintText,
                      labelText: FieldsEnum.LOCATION.label.toUpperCase(),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: AtTheme.borderColor)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AtTheme.borderColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AtTheme.borderColor),
                      )),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.search,
                ),
              ),
              Switch(
                value: localUser.allPrivate == true
                    ? true
                    : (locationField?.isPrivate ?? false),
                onChanged: (value) {
                  setState(() {
                    isLocation = value;
                    container.setPrivacy(FieldsEnum.LOCATION.name, value);
                  });
                },
                inactiveThumbColor: AtTheme.inactiveThumbColor,
                inactiveTrackColor: AtTheme.inactiveTrackColor,
                activeTrackColor: AtTheme.activeTrackColor,
                activeColor: AtTheme.activeColor,
              )
            ],
          ),
        ],
      ),
    );
  }

  getRadioWidget() {
    List<Widget> widget = [];
    int index = 0;
    if (!isShowRadiusOverlay) radiusValue = null;
    while (index < radiusItems.length) {
      formRadioWidget(widget, index);
      index++;
    }
    return widget;
  }

  formRadioWidget(List<Widget> widget, int index) {
    widget.addAll([
      Radio(
        activeColor: Colors.black,
        value: radiusValues[index],
        groupValue: radiusValue,
        onChanged: (dynamic newValue) {
          setState(() {
            radiusValue = newValue;
            _zoom = radiusItems[index].contains('5')
                ? 11.5
                : radiusItems[index].contains('10')
                    ? 10.5
                    : 12.5;
            googleController.animateCamera(CameraUpdate.newLatLngZoom(
                LatLng(_userLocation.latitude, _userLocation.longitude),
                _zoom));
            setCircle();
          });
        },
      ),
      Flexible(child: Text(radiusItems[index], style: TextStyle(fontSize: 18))),
    ]);
  }

  _getMap() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            children: <Widget>[
              Checkbox(
                  value: isShowRadiusOverlay,
                  activeColor: Colors.black,
                  onChanged: (value) {
                    setState(() {
                      isShowRadiusOverlay = value;
                      if (isShowRadiusOverlay) {
                        radiusValue = radiusValues[0];
                      }
                    });
                    setCircle();
                  }),
              Flexible(
                  child: Text(AtText.SHOW_RADIUS_OVERLAY,
                      style: TextStyle(fontSize: 17))),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(children: getRadioWidget()),
        ),
        Stack(
          children: <Widget>[
            Container(
              height: 350,
              child: GoogleMap(
                // mapType: MapType.normal,
                onMapCreated: (controller) {
                  googleController = controller;
                },
                initialCameraPosition: CameraPosition(
                  target:
                      LatLng(_userLocation?.latitude, _userLocation?.longitude),
                  zoom: _zoom,
                ),
                circles: isShowRadiusOverlay ? circles : {},
                onTap: (latlng) {
                  _setUserLocationFromMap(latlng);
                },
                gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
                  new Factory<OneSequenceGestureRecognizer>(
                      () => new EagerGestureRecognizer()),
                ].toSet(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Center(
                child: Container(
                    alignment: Alignment.center,
                    width: 190,
                    height: 35,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 2.0,
                            spreadRadius: 0.0,
                            offset: Offset(
                                2.0, 2.0), // shadow direction: bottom right
                          )
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50.0)),
                    child: Text(
                      AtText.MAP_PREVIEW,
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: AtFont.raleway,
                          color: Colors.black),
                      textAlign: TextAlign.center,
                    )),
              ),
            ),
          ],
        ),
      ],
    );
  }

  setCircle({lat, long}) {
    circles = Set.from([
      Circle(
        circleId: CircleId('AtCircle'),
        center: LatLng(
            lat ?? _userLocation.latitude, long ?? _userLocation.longitude),
        radius: radiusValue,
        fillColor: AtTheme.themecolor.withOpacity(0.3),
        strokeColor: Colors.transparent,
      )
    ]);
  }

  Future<void> _setUserLocationFromText(value, {isEdit}) async {
    try {
      List<Address> addressList =
          await Geocoder.local.findAddressesFromQuery(value);
      Coordinates coordinates = addressList[0].coordinates;
      _userLocation = LatLng(coordinates.latitude, coordinates.longitude);
      setCircle(lat: coordinates.latitude, long: coordinates.longitude);
      googleController?.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(coordinates.latitude, coordinates.longitude),
              zoom: _zoom)));
      if (isEdit == null) {
        _saveLocationForUser(value);
      }
      _isLoading = false;
      isDisplayMap = true;
      _logger.finer('Fetched address for user successfully');
    } on PlatformException catch (ex) {
      isDisplayMap = false;
      _isLoading = false;
      _logger.severe('Caught platform exception $ex');
      showDialog(
          barrierDismissible: false,
          context: (context),
          builder: (BuildContext context) {
            return AtErrorDialog.getAlertDialog(
                'Unable to find the location on map. Please try again.',
                context);
          });
    }
  }

  _setUserLocationFromMap(LatLng latlng) {
    _userLocation = latlng;
    setCircle(lat: latlng.latitude, long: latlng.longitude);
    googleController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: latlng, zoom: _zoom)));
    _setLocationFromCoordinates(Coordinates(latlng.latitude, latlng.longitude));
  }

  _setLocationFromCoordinates(Coordinates coordinates, {isEdit}) async {
    try {
      final fetchedLocation =
          await Geocoder.local.findAddressesFromCoordinates(coordinates);
      setState(() {
        if (isEdit == null) {
          locationController.text = fetchedLocation.first.addressLine;
          _saveLocationForUser(locationController.text);
        }
        isDisplayMap = true;
      });
    } on Exception catch (ex) {
      _logger.severe('Fetching location from coordinates throws $ex');
    }
  }
}
