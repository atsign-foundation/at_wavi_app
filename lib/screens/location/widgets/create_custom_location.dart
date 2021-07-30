import 'dart:convert';
import 'package:at_location_flutter/at_location_flutter.dart';
import 'package:at_location_flutter/utils/constants/constants.dart';
import 'package:at_wavi_app/common_components/create_marker.dart';
import 'package:at_wavi_app/common_components/custom_input_field.dart';
import 'package:at_wavi_app/common_components/loading_widget.dart';
import 'package:at_wavi_app/common_components/public_private_bottomsheet.dart';
import 'package:at_wavi_app/model/osm_location_model.dart';
import 'package:at_wavi_app/model/user.dart';
import 'package:at_wavi_app/routes/route_names.dart';
import 'package:at_wavi_app/routes/routes.dart';
import 'package:at_wavi_app/screens/location/widgets/select_location.dart';
import 'package:at_wavi_app/services/at_key_set_service.dart';
import 'package:at_wavi_app/services/size_config.dart';
import 'package:at_wavi_app/utils/at_enum.dart';
import 'package:at_wavi_app/utils/colors.dart';
import 'package:at_wavi_app/utils/text_styles.dart';
import 'package:flutter/material.dart';

class CreateCustomLocation extends StatefulWidget {
  final BasicData? basicData;
  const CreateCustomLocation({Key? key, this.basicData}) : super(key: key);

  @override
  _CreateCustomLocationState createState() => _CreateCustomLocationState();
}

class _CreateCustomLocationState extends State<CreateCustomLocation> {
  late BasicData _data;
  // late bool _isPrivate;
  // String _locationString = '', _accountName = '';
  OsmLocationModel? _osmLocationModel;

  @override
  initState() {
    // _isPrivate = false;
    _data = widget.basicData ?? BasicData(isPrivate: false);
    _osmLocationModel =
        OsmLocationModel.fromJson(jsonDecode(_data.value ?? '{}'));
    // _accountName = _data.accountName ?? '';
    // _isPrivate = _data.isPrivate;

    super.initState();
  }

  updateIsPrivate(bool _mode) {
    setState(() {
      // _isPrivate = _mode;
      _data.isPrivate = _mode;
    });
  }

  // @override
  // void dispose() {
  //   LocationWidgetData().dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    // return ValueListenableBuilder(
    //     valueListenable: LocationWidgetData().osmLocationModelNotifier!,
    //     builder: (BuildContext context, OsmLocationModel? _osmLocationModel,
    //         Widget? child) {
    _data.value = _osmLocationModel!.toJson();
    return Scaffold(
      bottomSheet: InkWell(
        onTap: () {
          if (_data.value != null) {
            _updateLocation(_osmLocationModel!);
          } else {
            if (_data.accountName != null) {
              return _showToast('Enter Location tag', isError: true);
            }
            _showToast('Enter Location', isError: true);
          }
        },
        child: Container(
            alignment: Alignment.center,
            height: 70.toHeight,
            width: SizeConfig().screenWidth,
            color: (_data.value != null)
                ? ColorConstants.black
                : ColorConstants.dullColor(
                    color: ColorConstants.black, opacity: 0.5),
            child: Text(
              'Done',
              style: CustomTextStyles.customTextStyle(ColorConstants.white,
                  size: 18),
            )),
      ),
      appBar: AppBar(
          toolbarHeight: 40,
          title: Text(
            'Custom Location',
            style: CustomTextStyles.customBoldTextStyle(
                Theme.of(context).primaryColor,
                size: 16),
          ),
          iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
          centerTitle: false,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          actions: [
            InkWell(
              onTap: () {
                showPublicPrivateBottomSheet(
                    onPublicClicked: () {
                      updateIsPrivate(false);
                    },
                    onPrivateClicked: () {
                      updateIsPrivate(true);
                    },
                    height: 200.toHeight);
              },
              child: Padding(
                  padding: EdgeInsets.only(right: 15),
                  child:
                      _data.isPrivate ? Icon(Icons.lock) : Icon(Icons.public)),
            )
          ]),
      body: SizedBox(
        height: SizeConfig().screenHeight - 80.toHeight - 55,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 15.toHeight,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.toWidth),
                child: Text('Tag',
                    style: TextStyles.lightText(
                        ColorConstants.black.withOpacity(0.5),
                        size: 16)),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 16.toWidth, vertical: 0.toHeight),
                child: CustomInputField(
                  borderColor: Colors.transparent,
                  focusedBorderColor: Colors.transparent,
                  width: double.infinity,
                  hintText: 'Enter the tag',
                  hintTextColor: ColorConstants.black.withOpacity(0.5),
                  bgColor: Colors.transparent,
                  textColor: ColorConstants.black,
                  initialValue: _data.accountName ?? '',
                  baseOffset: (_data.accountName ?? '').length,
                  height: 70,
                  expands: false,
                  maxLines: 1,
                  value: (str) => setState(() {
                    _data.accountName = str;
                  }),
                ),
              ),
              Divider(
                thickness: 1,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.toWidth),
                child: Text('Location',
                    style: TextStyles.lightText(
                        ColorConstants.black.withOpacity(0.5),
                        size: 16)),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 16.toWidth, vertical: 12.toHeight),
                child: CustomInputField(
                  isReadOnly: true,
                  borderColor: Colors.transparent,
                  focusedBorderColor: Colors.transparent,
                  width: double.infinity,
                  hintText: 'Search',
                  hintTextColor: ColorConstants.black.withOpacity(0.5),
                  bgColor: Colors.transparent,
                  textColor: ColorConstants.black,
                  // initialValue: _locationString,
                  // baseOffset: _locationString.length,
                  height: 70,
                  expands: false,
                  maxLines: 1,
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: StadiumBorder(),
                        builder: (BuildContext context) {
                          return Container(
                            height: SizeConfig().screenHeight * 0.9,
                            padding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: const Radius.circular(12.0),
                                topRight: const Radius.circular(12.0),
                              ),
                            ),
                            child: SelectLocation(
                              callbackFunction: (_finalData) {
                                print(
                                    '_finalData $_finalData ${_finalData.latLng}');
                                setState(() {
                                  _osmLocationModel = _finalData;
                                });
                              },
                            ),
                          );
                        });
                  },
                  value: (str) => setState(() {}),
                ),
              ),
              ((_osmLocationModel != null) &&
                      (_osmLocationModel!.latLng != null))
                  ? Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      height: 300,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Stack(
                        children: [
                          AbsorbPointer(
                            absorbing: true,
                            child: FlutterMap(
                              key: UniqueKey(),
                              options: MapOptions(
                                boundsOptions: FitBoundsOptions(
                                    padding: EdgeInsets.all(0)),
                                center: _osmLocationModel!.latLng!,
                                zoom: _osmLocationModel!.zoom!,
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
                                  Marker(
                                    width: 40,
                                    height: 50,
                                    point: _osmLocationModel!.latLng!,
                                    builder: (ctx) => Container(
                                        child: createMarker(
                                            diameterOfCircle:
                                                _osmLocationModel!.diameter!)),
                                  )
                                ])
                              ],
                            ),
                          ),
                          Positioned(
                            right: 10,
                            top: 10,
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: ColorConstants.LIGHT_GREY,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: IconButton(
                                  onPressed: () {
                                    SetupRoutes.push(
                                        context, Routes.PREVIEW_LOCATION,
                                        arguments: {
                                          'title': _data.accountName,
                                          'latLng': _osmLocationModel!.latLng!,
                                          'zoom': _osmLocationModel!.zoom!,
                                          'diameterOfCircle':
                                              _osmLocationModel!.diameter!,
                                        });
                                  },
                                  icon: Icon(Icons.fullscreen)),
                            ),
                          )
                        ],
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
    // });
  }

  _updateLocation(OsmLocationModel _osmData) async {
    print('_data.value ${_data.isPrivate} ${_data.accountName} ${_data.value}');

    LoadingDialog().show(text: 'Adding custom location');

    _data.type = CustomContentType.Text.name;
    var _res = await AtKeySetService()
        .updateCustomFields(AtCategory.LOCATION.name, [_data]);

    LoadingDialog().hide();
  }

  _showToast(String _text, {bool isError = false, Color? bgColor}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor:
          isError ? ColorConstants.RED : bgColor ?? ColorConstants.black,
      content: Text(
        _text,
        textAlign: TextAlign.center,
      ),
      duration: Duration(seconds: 1),
    ));
  }
}
