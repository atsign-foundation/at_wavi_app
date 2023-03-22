import 'dart:developer';
import 'dart:io';
import 'package:at_client/at_client.dart';
import 'package:at_client_mobile/at_client_mobile.dart';
import 'package:at_commons/at_commons.dart';
import 'package:at_contacts_flutter/utils/init_contacts_service.dart';
import 'package:at_onboarding_flutter/at_onboarding_flutter.dart';
import 'package:at_onboarding_flutter/services/onboarding_service.dart';
import 'package:at_sync_ui_flutter/at_sync_ui.dart';
import 'package:at_wavi_app/common_components/loading_widget.dart';
import 'package:at_wavi_app/desktop/routes/desktop_route_names.dart';
import 'package:at_wavi_app/model/at_follows_value.dart';
import 'package:at_wavi_app/routes/route_names.dart';
import 'package:at_wavi_app/routes/routes.dart';
import 'package:at_wavi_app/view_models/Internet_connectivity_checker.dart';
import 'package:at_wavi_app/view_models/base_model.dart';
import 'package:at_wavi_app/view_models/follow_service.dart';
import 'package:at_wavi_app/services/field_order_service.dart';
import 'package:at_wavi_app/services/at_key_get_service.dart';
import 'package:at_wavi_app/services/nav_service.dart';
import 'package:at_wavi_app/utils/colors.dart';
import 'package:at_wavi_app/utils/constants.dart';
import 'package:at_wavi_app/view_models/theme_view_model.dart';
import 'package:at_wavi_app/view_models/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:at_client/src/service/sync_service.dart';
import 'package:at_client/src/service/sync_service_impl.dart';
import 'package:at_sync_ui_flutter/at_sync_ui_flutter.dart';

class BackendService {
  static final BackendService _singleton = BackendService._internal();

  BackendService._internal();

  factory BackendService() {
    return _singleton;
  }

  late AtClientService atClientServiceInstance;
  late AtClient atClientInstance;
  late SyncService syncService;
  String? currentAtSign;
  AtClientPreference? atClientPreference;
  Directory? downloadDirectory;
  Map<String?, AtClientService> atClientServiceMap = {};

  onboard(
    String atSign, {
    AtClientPreference? atClientPreference,
    Color appColor = ColorConstants.green,
    VoidCallback? onSuccess,
    bool isSwitchAccount = false,
  }) async {
    var internetConnectivityChecker = Provider.of<InternetConnectivityChecker>(
        NavService.navKey.currentContext!,
        listen: false);

    if (Platform.isAndroid || Platform.isIOS) {
      await _checkForPermissionStatus();
    }

    final OnboardingService _onboardingService =
        OnboardingService.getInstance();
    atClientServiceMap = _onboardingService.atClientServiceMap;

    var atClientPrefernce;
    await getAtClientPreference()
        .then((value) => atClientPrefernce = value)
        .catchError((e) => print(e));
    AtOnboardingResult result;

    _onboardingService.setAtsign = atSign;

    // If no internet and atSign is present
    if (atSign != '' && !internetConnectivityChecker.isInternetAvailable) {
      AtClientService atClientService = AtClientService();
      var isOnboarded =
          await atClientService.isClientOnboarded(atSign, atClientPrefernce);
      if (isOnboarded) {
        AtClientManager.getInstance().setCurrentAtSign(
            atSign, MixedConstants.appNamespace, atClientPrefernce);

        LoadingDialog().show(text: '$atSign', heading: 'Loading');
        await onSuccessOnboard(atClientServiceMap, atSign);
        LoadingDialog().hide();
        if (Platform.isLinux || Platform.isMacOS || Platform.isWindows) {
          onSuccess?.call();
        } else {
          SetupRoutes.pushAndRemoveAll(
              NavService.navKey.currentContext!, Routes.HOME,
              arguments: {
                'key': Key(atSign),
                'isPreview': false,
              });
        }
        print(
            'isOnboarded: ${AtClientManager.getInstance().atClient.getCurrentAtSign()}');
      }
    } else {
      // If internet is available
      result = await AtOnboarding.onboard(
        context: NavService.navKey.currentContext!,
        config: AtOnboardingConfig(
          atClientPreference: atClientPrefernce!,
          domain: MixedConstants.ROOT_DOMAIN,
          rootEnvironment: RootEnvironment.Production,
          appAPIKey: MixedConstants.devAPIKey,
        ),
        isSwitchingAtsign: isSwitchAccount,
        atsign: atSign,
      );

      switch (result.status) {
        case AtOnboardingResultStatus.success:
          LoadingDialog().show(text: '$atSign', heading: 'Loading');
          await onSuccessOnboard(atClientServiceMap, result.atsign);
          LoadingDialog().hide();
          if (Platform.isLinux || Platform.isMacOS || Platform.isWindows) {
            onSuccess?.call();
          } else {
            SetupRoutes.pushAndRemoveAll(
                NavService.navKey.currentContext!, Routes.HOME,
                arguments: {
                  'key': Key(result.atsign!),
                  'isPreview': false,
                });
          }
          break;
        case AtOnboardingResultStatus.error:
          // TODO: Handle this case.
          showErrorSnackBar("error");
          break;
        case AtOnboardingResultStatus.cancel:
          // TODO: Handle this case.
          break;
      }
    }
  }

  Future<void> _checkForPermissionStatus() async {
    final existingCameraStatus = await Permission.camera.status;
    if (existingCameraStatus != PermissionStatus.granted) {
      await Permission.camera.request();
    }
    final existingStorageStatus = await Permission.storage.status;
    if (existingStorageStatus != PermissionStatus.granted) {
      await Permission.storage.request();
    }
  }

  onSuccessOnboard(Map<String?, AtClientService> atClientServiceMap,
      String? onboardedAtsign) async {
    // String? atSign = onboardedAtsign;
    // atClientInstance =
    //     atClientServiceMap[onboardedAtsign]!.atClientManager.atClient;
    // atClientServiceMap = atClientServiceMap;
    // syncService = AtClientManager.getInstance().syncService;
    // currentAtSign = atSign;
    // KeychainUtil.makeAtSignPrimary(atSign!);
    // atClientServiceInstance = atClientServiceMap[onboardedAtsign]!;
    // atClientServiceInstance = atClientServiceMap[onboardedAtsign]!;

    initializeContactsService(rootDomain: MixedConstants.ROOT_DOMAIN);
    Provider.of<FollowService>(NavService.navKey.currentContext!, listen: false)
        .resetData();
    await Provider.of<FollowService>(NavService.navKey.currentContext!,
            listen: false)
        .init();

    var _themeProvider = Provider.of<ThemeProvider>(
        NavService.navKey.currentContext!,
        listen: false);

    AtSyncUIService().init(
      appNavigator: NavService.navKey,
      onSuccessCallback: _onSuccessCallback,
      onErrorCallback: _onErrorCallback,
      primaryColor: (_themeProvider.highlightColor ?? ColorConstants.green),
    );
    AtSyncUIService().sync();

    _themeProvider.resetThemeData();
    await _themeProvider.checkThemeFromSecondary();

    AtKeyGetService().init();
    await Provider.of<UserProvider>(NavService.navKey.currentContext!,
            listen: false)
        .fetchUserData(BackendService().currentAtSign!);
  }

  Future<AtClientPreference> getAtClientPreference() async {
    if (Platform.isAndroid) {
      downloadDirectory = await path_provider.getExternalStorageDirectory();
    } else {
      downloadDirectory =
          await path_provider.getApplicationDocumentsDirectory();
    }

    var _atClientPreference = AtClientPreference()
      ..isLocalStoreRequired = true
      ..commitLogPath = downloadDirectory!.path
      ..downloadPath = downloadDirectory!.path
      ..namespace = MixedConstants.appNamespace
      ..rootDomain = MixedConstants.ROOT_DOMAIN
      ..syncRegex = MixedConstants.regex
      ..monitorHeartbeatInterval = Duration(seconds: 30)
      ..outboundConnectionTimeout = MixedConstants.TIME_OUT
      ..hiveStoragePath = downloadDirectory!.path
      ..monitorHeartbeatInterval = Duration(minutes: 1);
    return _atClientPreference;
  }

  sync() async {
    AtSyncUIService().sync(atSyncUIOverlay: AtSyncUIOverlay.snackbar);
  }

  _onSuccessCallback(syncStatus) async {
    print(
        'syncStatus type : $syncStatus, datachanged : ${syncStatus.dataChange}');
    var userProvider = Provider.of<UserProvider>(
        NavService.navKey.currentContext!,
        listen: false);

    if (syncStatus.dataChange &&
        userProvider.status[userProvider.FETCH_USER] != Status.Loading) {
      await userProvider.fetchUserData(BackendService().currentAtSign!);
    }
  }

  _onErrorCallback(syncStatus) async {
    showErrorSnackBar('Sync failed');
  }

  ///Fetches privatekey for [atsign] from device keychain.
  Future<String?> getPrivateKey(String atsign) async {
    return await KeychainUtil.getPrivateKey(atsign);
  }

  ///Fetches atsign from device keychain.
  Future<String?> getAtSign() async {
    await getAtClientPreference().then((value) {
      return atClientPreference = value;
    });

    atClientServiceInstance = AtClientService();

    return await KeychainUtil.getAtSign();
  }

  ///Returns List<AtKey> for the current @sign.
  Future<List<AtKey>> getAtKeys([String? sharedBy]) async {
    var regex = MixedConstants.syncRegex;
    var scanKeys =
        await atClientInstance.getAtKeys(sharedBy: sharedBy, regex: regex);
    scanKeys.retainWhere(
      (scanKey) =>
          !scanKey.metadata!.isCached &&
          compareAtSign(scanKey.sharedBy, atClientInstance.getCurrentAtSign()),
    );

    return scanKeys;
  }

  bool compareAtSign(String? atsign1, String? atsign2) {
    if (atsign1 == null || atsign2 == null) {
      return false;
    }

    if (atsign1[0] != '@') {
      atsign1 = '@$atsign1';
    }
    if (atsign2[0] != '@') {
      atsign2 = '@$atsign2';
    }
    return atsign1.toLowerCase() == atsign2.toLowerCase() ? true : false;
  }

  ///Resets [atsigns] list from device storage.
  Future<void> resetAtsigns(List atsigns) async {
    for (String atsign in atsigns) {
      await KeychainUtil.resetAtSignFromKeychain(atsign);
      atClientServiceMap.remove(atsign);
    }
  }

  deleteAtSignFromKeyChain(String atsign) async {
    List<String>? atSignList = await KeychainUtil.getAtsignList();

    await KeychainUtil.deleteAtSignFromKeychain(atsign);

    if (atSignList != null) {
      atSignList.removeWhere((element) => element == currentAtSign);
    }

    var nextAtsignToOnboard;
    if (atSignList == null || atSignList.isEmpty) {
      nextAtsignToOnboard = '';
    } else {
      nextAtsignToOnboard = atSignList.first;
    }

    if (nextAtsignToOnboard == '') {
      await SetupRoutes.pushAndRemoveAll(
          NavService.navKey.currentContext!, Routes.WELCOME_SCREEN);
    } else {
      await onboard(nextAtsignToOnboard);
    }
  }

  Future<AtFollowsValue> scanAndGet(String regex) async {
    var scanKey = await BackendService()
        .atClientInstance
        .getAtKeys(regex: regex)
        .timeout(Duration(seconds: MixedConstants.responseTimeLimit),
            onTimeout: () {}());

    AtFollowsValue value =
        scanKey.isNotEmpty ? await this.get(scanKey[0]) : AtFollowsValue();
    return value;
  }

  Future<AtFollowsValue> get(AtKey atkey) async {
    var response = await BackendService().atClientInstance.get(atkey).timeout(
        Duration(seconds: MixedConstants.responseTimeLimit), onTimeout: () {
      print('time out');
    }());

    AtFollowsValue val = AtFollowsValue();
    val
      ..metadata = response.metadata
      ..value = response.value
      ..atKey = atkey;
    return val;
  }

  String? formatAtSign(String? atsign) {
    if (atsign == null) {
      return null;
    } else if (atsign.contains(':')) {
      throw Exception('Invalid Atsign');
    }
    atsign = atsign.trim().toLowerCase().replaceAll(' ', '');
    atsign = !atsign.startsWith('@') ? '@' + atsign : atsign;
    return atsign;
  }

  Future<bool> put(AtKey atKey, String? value) async {
    return await atClientInstance.put(atKey, value).timeout(
        Duration(seconds: MixedConstants.responseTimeLimit), onTimeout: () {
      print('time out in put service ');
    }());
  }

  showErrorSnackBar(dynamic error) {
    try {
      ScaffoldMessenger.of(NavService.navKey.currentContext!)
          .showSnackBar(SnackBar(
        backgroundColor: ColorConstants.RED,
        content: Text(
          '$error',
          style: TextStyle(
              color: ColorConstants.white,
              fontSize: 16,
              letterSpacing: 0.1,
              fontWeight: FontWeight.normal),
        ),
      ));
    } catch (e) {
      print('Error while showing error snackbar $e');
    }
  }

  resetDevice(List checkedAtsigns) async {
    Navigator.of(NavService.navKey.currentContext!).pop();
    await resetAtsigns(checkedAtsigns).then((value) async {
      print('reset done');
    }).catchError((e) {
      print('error in reset: $e');
    });
  }

  onboardNextAtsign({bool isCheckDesktop = false}) async {
    var atSignList = await KeychainUtil.getAtsignList();

    if ((atSignList ?? []).length == 0) {
      final OnboardingService _onboardingService =
          OnboardingService.getInstance();

      _onboardingService.setAtsign = null;
    }

    if (!isCheckDesktop) {
      if (atSignList != null &&
          atSignList.isNotEmpty &&
          currentAtSign != atSignList.first) {
        await Navigator.pushNamedAndRemoveUntil(
            NavService.navKey.currentContext!,
            Routes.WELCOME_SCREEN,
            (Route<dynamic> route) => false);
      } else if (atSignList == null || atSignList.isEmpty) {
        await Navigator.pushNamedAndRemoveUntil(
            NavService.navKey.currentContext!,
            Routes.WELCOME_SCREEN,
            (Route<dynamic> route) => false);
      }
    } else {
      if (atSignList != null &&
          atSignList.isNotEmpty &&
          currentAtSign != atSignList.first) {
        await Navigator.pushNamedAndRemoveUntil(
            NavService.navKey.currentContext!,
            DesktopRoutes.DESKTOP_LOGIN,
            (Route<dynamic> route) => false);
      } else if (atSignList == null || atSignList.isEmpty) {
        await Navigator.pushNamedAndRemoveUntil(
            NavService.navKey.currentContext!,
            DesktopRoutes.DESKTOP_LOGIN,
            (Route<dynamic> route) => false);
      }
    }
  }
}
