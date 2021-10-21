enum DesktopSideMenu {
  profile,
  media,
  basicDetails,
  additionalDetails,
  location,
  socialChannel,
  gameChannel,
  featuredChannel,
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
        return 'Basic Details';
      case DesktopSideMenu.additionalDetails:
        return 'Additional Details';
      case DesktopSideMenu.location:
        return 'Location';
      case DesktopSideMenu.socialChannel:
        return 'Social Channel';
      case DesktopSideMenu.gameChannel:
        return 'Game Channel';
      case DesktopSideMenu.featuredChannel:
        return 'Featured Channel';
      case DesktopSideMenu.appearance:
        return 'Appearance';
      default:
        return 'Unknown';
    }
  }
}
