import 'dart:io';
import 'package:at_client/at_client.dart';
import 'package:at_client_mobile/at_client_mobile.dart';
import 'package:at_commons/at_commons.dart';
import 'package:at_contacts_flutter/utils/init_contacts_service.dart';
import 'package:at_onboarding_flutter/at_onboarding_flutter.dart';
import 'package:at_wavi_app/common_components/loading_widget.dart';
import 'package:at_wavi_app/model/at_follows_value.dart';
import 'package:at_wavi_app/routes/route_names.dart';
import 'package:at_wavi_app/routes/routes.dart';
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
import 'package:provider/provider.dart';
import 'package:at_client/src/service/sync_service.dart';
import 'package:at_client/src/service/sync_service_impl.dart';

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

  onboard(String atSign, {AtClientPreference? atClientPreference}) async {
    var atClientPrefernce;
    await getAtClientPreference()
        .then((value) => atClientPrefernce = value)
        .catchError((e) => print(e));
    Onboarding(
      atsign: atSign,
      context: NavService.navKey.currentContext!,
      atClientPreference: atClientPrefernce,
      domain: MixedConstants.ROOT_DOMAIN,
      appAPIKey: MixedConstants.devAPIKey,
      appColor: ColorConstants.green,
      rootEnvironment: RootEnvironment.Production,
      onboard: (atClientServiceMap, onboardedAtsign) async {
        LoadingDialog().show(text: '$onboardedAtsign', heading: 'Loading');
        await onSuccessOnboard(atClientServiceMap, onboardedAtsign);
        LoadingDialog().hide();
        SetupRoutes.pushAndRemoveAll(
            NavService.navKey.currentContext!, Routes.HOME);
      },
      onError: (error) {
        print('Onboarding throws $error error');
      },
    );
  }

  onSuccessOnboard(Map<String?, AtClientService> atClientServiceMap,
      String? onboardedAtsign) async {
    String? atSign = onboardedAtsign;
    atClientInstance =
        atClientServiceMap[onboardedAtsign]!.atClientManager.atClient;
    atClientServiceMap = atClientServiceMap;
    syncService = AtClientManager.getInstance().syncService;
    currentAtSign = atSign;
    KeychainUtil.makeAtSignPrimary(atSign!);
    atClientServiceInstance = atClientServiceMap[onboardedAtsign]!;
    atClientServiceInstance = atClientServiceMap[onboardedAtsign]!;

    initializeContactsService(rootDomain: MixedConstants.ROOT_DOMAIN);
    Provider.of<FollowService>(NavService.navKey.currentContext!, listen: false)
        .resetData();
    await Provider.of<FollowService>(NavService.navKey.currentContext!,
            listen: false)
        .init();
    await sync();
    Provider.of<ThemeProvider>(NavService.navKey.currentContext!, listen: false)
        .resetThemeData();
    await Provider.of<ThemeProvider>(NavService.navKey.currentContext!,
            listen: false)
        .checkThemeFromSecondary();

    AtKeyGetService().init();
    await Provider.of<UserProvider>(NavService.navKey.currentContext!,
            listen: false)
        .fetchUserData(BackendService().currentAtSign!);
  }

  Future<AtClientPreference> getAtClientPreference() async {
    if (Platform.isIOS) {
      downloadDirectory =
          await path_provider.getApplicationDocumentsDirectory();
    } else {
      downloadDirectory = await path_provider.getExternalStorageDirectory();
    }

    var _atClientPreference = AtClientPreference()
      ..isLocalStoreRequired = true
      ..commitLogPath = downloadDirectory!.path
      ..downloadPath = downloadDirectory!.path
      ..namespace = MixedConstants.appNamespace
      ..rootDomain = MixedConstants.ROOT_DOMAIN
      ..syncRegex = MixedConstants.regex
      ..outboundConnectionTimeout = MixedConstants.TIME_OUT
      ..hiveStoragePath = downloadDirectory!.path;
    return _atClientPreference;
  }

  sync() async {
    syncService = AtClientManager.getInstance().syncService;
    syncService.sync(onDone: _onSuccessCallback);
    syncService.setOnDone(_onSuccessCallback);
  }

  _onSuccessCallback(SyncResult syncStatus) async {
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
    scanKeys.retainWhere((scanKey) =>
        !scanKey.metadata!.isCached &&
        '@' + (scanKey.sharedBy ?? '') == atClientInstance.getCurrentAtSign());
    return scanKeys;
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
}
