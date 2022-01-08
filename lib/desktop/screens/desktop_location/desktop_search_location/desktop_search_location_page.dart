import 'package:at_location_flutter/at_location_flutter.dart';
import 'package:at_location_flutter/service/search_location_service.dart';
import 'package:at_wavi_app/desktop/screens/desktop_profile_basic_info/desktop_select_location/desktop_select_location_page.dart';
import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/desktop/utils/desktop_dimens.dart';
import 'package:at_wavi_app/desktop/widgets/buttons/desktop_icon_button.dart';
import 'package:at_wavi_app/desktop/widgets/desktop_button.dart';
import 'package:at_wavi_app/model/here_result.dart';
import 'package:at_wavi_app/model/osm_location_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import 'desktop_search_location_model.dart';

class DesktopSearchLocationPage extends StatefulWidget {
  const DesktopSearchLocationPage({Key? key}) : super(key: key);

  @override
  _DesktopSearchLocationPageState createState() =>
      _DesktopSearchLocationPageState();
}

class _DesktopSearchLocationPageState extends State<DesktopSearchLocationPage> {
  final keywordTextController = TextEditingController();
  late DesktopSearchLocationModel _model;
  bool _isNear = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _model = DesktopSearchLocationModel();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return ChangeNotifierProvider.value(
      value: _model,
      child: Container(
        width: MediaQuery.of(context).size.width / 2,
        padding: EdgeInsets.all(DesktopDimens.paddingNormal),
        decoration: BoxDecoration(
          color: appTheme.backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: keywordTextController,
                    decoration: InputDecoration(hintText: 'Search'),
                    onChanged: (text) {
                      _searchLocation();
                    },
                  ),
                ),
                SizedBox(
                  width: DesktopDimens.paddingNormal,
                ),
                DesktopIconButton(
                  iconData: Icons.search,
                  onPressed: () {
                    _searchLocation();
                  },
                ),
              ],
            ),
            SizedBox(
              height: DesktopDimens.paddingNormal,
            ),
            Row(
              children: [
                Checkbox(
                  value: _isNear,
                  onChanged: (value) {
                    setState(() {
                      _isNear = !_isNear;
                    });
                  },
                  checkColor: Colors.white,
                  activeColor: appTheme.primaryColor,
                ),
                Text(
                  'Near me',
                  style: appTheme.textTheme.bodyText2,
                ),
                Spacer(),
                DesktopButton(
                  title: 'Using GPS',
                  width: 120,
                  backgroundColor: appTheme.secondaryBackgroundColor,
                  onPressed: openSelectLocation,
                )
              ],
            ),
            SizedBox(
              height: DesktopDimens.paddingNormal,
            ),
            Expanded(
              child: Consumer<DesktopSearchLocationModel>(
                builder: (_, model, child) {
                  return ListView.separated(
                    itemCount: _model.resultList.length,
                    itemBuilder: (context, index) {
                      final item = _model.resultList[index];
                      return GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          _onSelectLocation(item);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: DesktopDimens.paddingSmall,
                          ),
                          child: Text(item.title ?? ''),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        color: appTheme.separatorColor,
                      );
                    },
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Spacer(),
                DesktopWhiteButton(
                  title: 'Cancel',
                  width: 180,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _searchLocation() async {
    final keyword = keywordTextController.text;
    if (keyword.isEmpty) {
      return;
    } else {
      final currentLocation = await getMyLocation();
      if (!_isNear) {
        // ignore: await_only_futures
        // SearchLocationService().getAddressLatLng(keyword, null);
        _model.getAddressLatLng(keyword, null);
      } else {
        // ignore: await_only_futures
        _model.getAddressLatLng(keyword, currentLocation);
      }
    }
  }

  void _onSelectLocation(HereResult location) {
    double? lat = location.position?.lat;
    double? lng = location.position?.lng;
    if (lat != null && lng != null) {
      openSelectLocation(latLng: LatLng(lat, lng));
    }
  }

  void openSelectLocation({LatLng? latLng}) async {
    final currentLocation = await getMyLocation();
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
        backgroundColor: Colors.transparent,
        child: DesktopSelectLocationPage(
          displayName: '',
          point: latLng ?? currentLocation,
        ),
      ),
    );
    if (result is OsmLocationModel) {
      Navigator.pop(context, result);
    }
  }
}
