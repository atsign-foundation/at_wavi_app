class MixedConstants {
  // static const String WEBSITE_URL = 'https://staging.atsign.wtf/';
  static const String WEBSITE_URL = 'https://atsign.com/';

  // for local server
  // static const String ROOT_DOMAIN = 'vip.ve.atsign.zone';

  // for staging server
  // static const String ROOT_DOMAIN = 'root.atsign.wtf';
  // for production server
  static const String ROOT_DOMAIN = 'root.atsign.org';

  static String devAPIKey = '560w-806a-zzev-z02i-6a3p';

  static const int ROOT_PORT = 64;

  static const String TERMS_CONDITIONS = 'https://atsign.com/terms-conditions/';

  static const String FILEBIN_URL = 'https://filebin2.aws.atsign.cloud/';
  // static const String PRIVACY_POLICY = 'https://atsign.com/privacy-policy/';
  static const String PRIVACY_POLICY =
      "https://atsign.com/apps/atmosphere/atmosphere-privacy/";

  static const String WAVI_API = 'https://wavi.ng/api/?atp=';

  // the time to await for file transfer acknowledgement in milliseconds
  static const int TIME_OUT = 60000;

  static String appNamespace = 'wavi';
  static String regex =
      '(.$appNamespace|atconnections|[0-9a-f]{8}(?:-[0-9a-f]{4}){3}-[0-9a-f]{12})';

  static const String syncRegex = '.(wavi|persona)@';

  static const String FOLLOWING_KEY = 'following_by_self';
  static const String FOLLOWERS_KEY = 'followers_of_self';

  static const String MAP_KEY = 'B3Wus46C2WZFhwZKQkEx';
  static const String API_KEY = 'yRCeKfJDPQDTp11YI1db67J_fww80QP6R3Llckg-REw';
  static final String twitterBearerToken = '';
  static const int responseTimeLimit = 30;
  static const String fieldOrderKey = 'field_order_of_self';
}
