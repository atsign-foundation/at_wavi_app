import 'package:at_wavi_app/common_components/loading_widget.dart';
import 'package:at_wavi_app/model/user.dart';
import 'package:at_wavi_app/routes/route_names.dart';
import 'package:at_wavi_app/routes/routes.dart';
import 'package:at_wavi_app/services/common_functions.dart';
import 'package:at_wavi_app/services/field_order_service.dart';
import 'package:at_wavi_app/services/search_service.dart';
import 'package:at_wavi_app/services/size_config.dart';
import 'package:at_wavi_app/utils/colors.dart';
import 'package:at_wavi_app/utils/text_styles.dart';
import 'package:at_wavi_app/view_models/user_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qr_reader/flutter_qr_reader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class QRScanner extends StatefulWidget {
  const QRScanner({Key? key}) : super(key: key);

  @override
  State<QRScanner> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  //if flag is true the camera will scan for a qr code
  bool flag = true;
  QrReaderViewController? _controller;

  @override
  initState() {
    checkPermissions();
    super.initState();
  }

  checkPermissions() async {
    var cameraStatus = await Permission.camera.status;
    print("camera status => $cameraStatus");

    if (!cameraStatus.isGranted &&
        !cameraStatus.isPermanentlyDenied &&
        !cameraStatus.isLimited) {
      await askPermissions(Permission.camera);
    }
  }

  askPermissions(Permission type) async {
    if (type == Permission.camera) {
      var _res = await Permission.camera.request();

      if (_res == PermissionStatus.granted ||
          _res == PermissionStatus.limited) {
        setState(() {});
      }
    }
  }

  Future<void> onScan(
      String searchedAtsign, List<Offset> offsets, context) async {
    LoadingDialog().show(text: '$searchedAtsign', heading: 'Fetching');

    var _searchedAtsignData =
        SearchService().getAlreadySearchedAtsignDetails(searchedAtsign);

    late bool _isPresent;
    if (_searchedAtsignData != null) {
      _isPresent = true;
    } else {
      _isPresent = await CommonFunctions().checkAtsign(searchedAtsign);
    }

    if (_isPresent) {
      SearchInstance? _searchService =
          await SearchService().getAtsignDetails(searchedAtsign);
      User? _res = _searchService?.user;

      LoadingDialog().hide();

      /// in case the search is cancelled, dont do anything
      if (_searchService == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: ColorConstants.RED,
          content: Text(
            'Something went wrong',
            style: CustomTextStyles.customTextStyle(
              ColorConstants.white,
            ),
          ),
        ));
        return;
      }

      Provider.of<UserPreview>(context, listen: false).setUser = _res;
      FieldOrderService().setPreviewOrder = _searchService.fieldOrders;

      await SetupRoutes.replace(context, Routes.HOME, arguments: {
        'key': Key(searchedAtsign),
        'themeData': _searchService.currentAtsignThemeData,
        'isPreview': true,
      });
    } else {
      LoadingDialog().hide();

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: ColorConstants.RED,
        content: Text(
          '$searchedAtsign not found',
          style: CustomTextStyles.customTextStyle(
            ColorConstants.white,
          ),
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan a QR code'),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.10),
            Expanded(
              child: Center(
                child: Builder(
                  builder: (context) => Container(
                    alignment: Alignment.center,
                    width: 300.toWidth,
                    height: 350.toHeight,
                    color: Colors.black,
                    child: QrReaderView(
                      width: 300.toWidth,
                      height: 350.toHeight,
                      callback: (container) async {
                        this._controller = container;
                        await _controller!.startCamera((data, offsets) async {
                          // _controller?.stopCamera();
                          //confirm data for invalids
                          //check and make sure that "data" has a valid atsign
                          if (flag) {
                            flag = false;
                            bool _atSignValid =
                                await CommonFunctions().checkAtsign(data);
                            if (_atSignValid) {
                              // flag = true;
                              _controller?.stopCamera();
                              await onScan(data, offsets, context);
                            } else {
                              // flag = false;
                              // if (flag == false) {
                              print("this in else block: ${data}");
                              await ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                backgroundColor: ColorConstants.RED,
                                content: Text(
                                  'QR code is invalid.${data}',
                                  style: CustomTextStyles.customTextStyle(
                                    ColorConstants.white,
                                  ),
                                ),
                              ));
                              // }
                            }
                            flag = true;
                          }
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.10),
          ],
        ),
      ),
    );
  }
}
