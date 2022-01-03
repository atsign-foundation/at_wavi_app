enum DesktopSideMenu {
  profile,
  media,
  basicDetails,
  additionalDetails,
  location,
  socialChannel,
  gameChannel,
  //featuredChannel,
  appearance,
}

extension DesktopSideMenuExt on DesktopSideMenu {
  String get title {
    switch (this) {
      case DesktopSideMenu.profile:
        return 'Profile Picture';
      case DesktopSideMenu.media:
        return 'Media';
      case DesktopSideMenu.basicDetails:
        return 'Contact';
      case DesktopSideMenu.additionalDetails:
        return 'About';
      case DesktopSideMenu.location:
        return 'Location';
      case DesktopSideMenu.socialChannel:
        return 'Social';
      case DesktopSideMenu.gameChannel:
        return 'Gaming';
      // case DesktopSideMenu.featuredChannel:
      //   return 'Featured Channel';
      case DesktopSideMenu.appearance:
        return 'Appearance';
      default:
        return 'Unknown';
    }
  }
}
