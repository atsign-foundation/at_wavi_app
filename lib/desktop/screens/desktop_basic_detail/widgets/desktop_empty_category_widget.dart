import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:at_wavi_app/desktop/widgets/desktop_empty_widget.dart';
import 'package:at_wavi_app/utils/at_enum.dart';
import 'package:at_wavi_app/utils/images.dart';
import 'package:flutter/material.dart';

class DesktopEmptyCategoryWidget extends StatelessWidget {
  final AtCategory atCategory;
  final VoidCallback onAddDetailsPressed;

  DesktopEmptyCategoryWidget({
    required this.atCategory,
    required this.onAddDetailsPressed,
  });

  @override
  Widget build(BuildContext context) {
    return DesktopEmptyWidget(
      image: Image.asset(
        atCategory.imageData,
        width: 220,
        height: 215,
      ),
      title: atCategory.title,
      description: atCategory.description,
      buttonTitle: 'Add Details',
      onButtonPressed: onAddDetailsPressed,
    );
  }
}

extension AtCategoryExt on AtCategory {
  String get imageData {
    switch (this) {
      case AtCategory.DETAILS:
        return Images.introBasicDetail;
      case AtCategory.ADDITIONAL_DETAILS:
        return Images.introAdditionalDetail;
      case AtCategory.LOCATION:
        return Images.introLocation;
      case AtCategory.SOCIAL:
        return Images.introSocialChannel;
      case AtCategory.GAMER:
        return Images.introGameChannel;
      default:
        return Images.introBasicDetail;
    }
  }

  String get title {
    switch (this) {
      case AtCategory.DETAILS:
        return 'Add your Basic details';
      case AtCategory.ADDITIONAL_DETAILS:
        return 'Add your Additional details';
      case AtCategory.LOCATION:
        return 'Add your Location details';
      case AtCategory.SOCIAL:
        return 'Add your Social Channel';
      case AtCategory.GAMER:
        return 'Add your Game channels';
      default:
        return '';
    }
  }

  String get description {
    switch (this) {
      case AtCategory.DETAILS:
        return 'Add basic details to start sharing your profile with others.';
      case AtCategory.ADDITIONAL_DETAILS:
        return 'Add additional details to start sharing your profile with others.';
      case AtCategory.LOCATION:
        return 'Add location details to start sharing your profile with others.';
      case AtCategory.SOCIAL:
        return 'Add Social details to start sharing your profile with others.';
      case AtCategory.GAMER:
        return 'Add Game channels to start sharing your profile with others.';
      default:
        return '';
    }
  }
}
