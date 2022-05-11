import 'package:at_wavi_app/desktop/services/theme/app_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DesktopCircleAvatar extends StatelessWidget {
  final String url;
  final double size;

  DesktopCircleAvatar({
    required this.url,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    bool isValidUrl = Uri.tryParse(url)?.isAbsolute == true;
    return Container(
      width: size,
      height: size,
      child: isValidUrl
          ? ClipRRect(
              child: CachedNetworkImage(
                imageUrl: url,
                progressIndicatorBuilder: (context, url, downloadProgress) {
                  return Container(
                    width: size,
                    height: size,
                    child: CircularProgressIndicator(
                      value: downloadProgress.progress,
                      backgroundColor: appTheme.primaryColor,
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.transparent),
                    ),
                  );
                },
                errorWidget: (context, url, error) {
                  return Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: Icon(
                      Icons.person_outline_rounded,
                      color: Colors.grey,
                    ),
                  );
                },
                fit: BoxFit.fill,
              ),
              borderRadius: BorderRadius.circular(size / 2),
            )
          : Container(
              width: double.infinity,
              height: double.infinity,
              child: Icon(
                Icons.person_outline_rounded,
                color: Colors.grey,
              ),
            ),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(size / 2),
      ),
    );
  }
}
