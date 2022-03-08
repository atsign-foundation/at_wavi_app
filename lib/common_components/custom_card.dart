import 'package:at_wavi_app/routes/route_names.dart';
import 'package:at_wavi_app/routes/routes.dart';
import 'package:at_wavi_app/utils/colors.dart';
import 'package:at_wavi_app/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:at_wavi_app/services/size_config.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:open_mail_app/open_mail_app.dart';

class CustomCard extends StatelessWidget {
  final String? title, subtitle;
  final bool isUrl;
  late bool _isDark;
  late ThemeData themeData;
  CustomCard(
      {this.title,
      required this.subtitle,
      this.isUrl = false,
      required this.themeData});

  void setThemeData(BuildContext context) {
    _isDark = themeData.scaffoldBackgroundColor == ColorConstants.black;
  }

  @override
  Widget build(BuildContext context) {
    setThemeData(context);
    return Container(
      color: themeData.backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            title != null
                ? Text(
                    '${title![0].toUpperCase()}${title!.substring(1)}',
                    style: TextStyles.lightText(
                        themeData.primaryColor.withOpacity(0.5),
                        size: 16),
                  )
                : SizedBox(),
            SizedBox(height: 6),
            subtitle != null
                ? GestureDetector(
                    onTap: () async {
                      // if (!isUrl) {
                      //   return;
                      // }
                      // SetupRoutes.push(context, Routes.WEB_VIEW,
                      //     arguments: {'title': title, 'url': subtitle});

                      if (subtitle != null) {
                        EmailContent emailContent = EmailContent(to: [
                          subtitle!,
                        ]);

                        OpenMailAppResult result =
                            await OpenMailApp.composeNewEmailInMailApp(
                                nativePickerTitle:
                                    'Select email app to compose',
                                emailContent: emailContent);
                        if (!result.didOpen && !result.canOpen) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(
                              "No Email applications found",
                              textAlign: TextAlign.center,
                            ),
                            duration: Duration(seconds: 1),
                          ));
                        } else if (!result.didOpen && result.canOpen) {
                          showDialog(
                            context: context,
                            builder: (_) => MailAppPickerDialog(
                              mailApps: result.options,
                              emailContent: emailContent,
                            ),
                          );
                        }
                      }
                    },
                    child: HtmlWidget(
                      subtitle!,
                      textStyle: TextStyle(
                        color: isUrl
                            ? ColorConstants.orange
                            : themeData.primaryColor,
                        fontSize: 16.toFont,
                      ),
                      webView: true,
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
