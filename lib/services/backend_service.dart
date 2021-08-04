import 'dart:convert';
import 'dart:io';
import 'package:at_client/at_client.dart';
import 'package:at_client_mobile/at_client_mobile.dart';
import 'package:at_commons/at_commons.dart';
import 'package:at_contacts_flutter/utils/init_contacts_service.dart';
import 'package:at_onboarding_flutter/at_onboarding_flutter.dart';
import 'package:at_wavi_app/model/at_follows_value.dart';
import 'package:at_wavi_app/routes/route_names.dart';
import 'package:at_wavi_app/routes/routes.dart';
import 'package:at_wavi_app/services/follow_service.dart';
import 'package:at_wavi_app/services/at_key_get_service.dart';
import 'package:at_wavi_app/services/nav_service.dart';
import 'package:at_wavi_app/utils/constants.dart';
import 'package:at_wavi_app/view_models/notification_provider.dart';
import 'package:at_wavi_app/view_models/theme_view_model.dart';
import 'package:at_wavi_app/view_models/user_provider.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:provider/provider.dart';

class BackendService {
  static final BackendService _singleton = BackendService._internal();
  BackendService._internal();

  factory BackendService() {
    return _singleton;
  }

  late AtClientService atClientServiceInstance;
  late AtClientImpl atClientInstance;
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
      onboard: (value, atsign) async {
        String? atSign = value[atsign]!.atClient!.currentAtSign;
        atClientInstance = value[atsign]!.atClient!;
        atClientServiceMap = value;
        currentAtSign = atSign;
        atClientServiceMap[atSign]!.makeAtSignPrimary(atSign!);
        startMonitor(atsign: atsign, value: value);
        await FollowService().init();
        initializeContactsService(
            atClientInstance, atClientInstance.currentAtSign!);
        Provider.of<ThemeProvider>(NavService.navKey.currentContext!,
                listen: false)
            .resetThemeData();
        AtKeyGetService().init();
        Provider.of<UserProvider>(NavService.navKey.currentContext!,
                listen: false)
            .fetchUserData(BackendService().currentAtSign!);
        SetupRoutes.pushAndRemoveAll(
            NavService.navKey.currentContext!, Routes.HOME);
      },
      onError: (error) {
        print('Onboarding throws $error error');
      },
    );
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
      ..syncStrategy = SyncStrategy.IMMEDIATE
      ..rootDomain = MixedConstants.ROOT_DOMAIN
      ..syncRegex = MixedConstants.regex
      ..outboundConnectionTimeout = MixedConstants.TIME_OUT
      ..hiveStoragePath = downloadDirectory!.path;
    return _atClientPreference;
  }

  Future<bool> startMonitor({value, atsign}) async {
    if (value.containsKey(atsign)) {
      currentAtSign = atsign;
      atClientServiceMap = value;
      atClientInstance = value[atsign].atClient;
      atClientServiceInstance = value[atsign];
    }

    String? privateKey = await getPrivateKey(atsign);
    await atClientInstance.startMonitor(privateKey!, _notificationCallBack);
    print('monitor started');
    return true;
  }

  _notificationCallBack(response) async {
    print('_notificationCallBack: $response');
    response = response.toString().replaceAll('notification:', '').trim();

    var responseJson = jsonDecode(response);
    var value = responseJson['value'];
    var fromAtSign = responseJson['from'];
    var notificationKey = responseJson['key'];
    var decryptedMessage = await atClientInstance.encryptionService!
        .decrypt(value, fromAtSign)
        // ignore: return_of_invalid_type_from_catch_error
        .catchError((e) => print('error in decrypting: $e'));

    Provider.of<NotificationProvider>(NavService.navKey.currentContext!,
            listen: false)
        .addNotification(notificationKey, fromAtSign, decryptedMessage);
  }

  String formatIncomingKey(String key, String fromAtSign) {
    var notificationKey = key.toString().replaceAll(fromAtSign, '');
    notificationKey = notificationKey.toString().replaceAll(currentAtSign!, '');
    notificationKey = notificationKey.toString().replaceAll('public', '');
    notificationKey = notificationKey.toString().replaceAll('.wavi', '');
    notificationKey = notificationKey.toString().replaceAll(':', '');
    return notificationKey;
  }

  ///Fetches privatekey for [atsign] from device keychain.
  Future<String?> getPrivateKey(String atsign) async {
    return await atClientServiceInstance.getPrivateKey(atsign);
  }

  ///Fetches atsign from device keychain.
  Future<String?> getAtSign() async {
    await getAtClientPreference().then((value) {
      return atClientPreference = value;
    });

    atClientServiceInstance = AtClientService();

    return await atClientServiceInstance.getAtSign();
  }

  ///Returns List<AtKey> for the current @sign.
  Future<List<AtKey>> getAtKeys([String? sharedBy]) async {
    var regex = MixedConstants.syncRegex;
    var scanKeys =
        await atClientInstance.getAtKeys(sharedBy: sharedBy, regex: regex);
    scanKeys.retainWhere((scanKey) =>
        !scanKey.metadata!.isCached &&
        '@' + (scanKey.sharedBy ?? '') == atClientInstance.currentAtSign);
    return scanKeys;
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
