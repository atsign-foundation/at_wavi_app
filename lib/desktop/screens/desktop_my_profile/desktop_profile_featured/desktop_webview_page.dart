import 'package:at_wavi_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DesktopWebViewScreen extends StatefulWidget {
  final String title;
  final String url;
  final bool isShareProfileScreen;

  const DesktopWebViewScreen(
      {Key? key,
      required this.title,
      required this.url,
      this.isShareProfileScreen = false})
      : super(key: key);

  @override
  _DesktopWebViewScreenState createState() => _DesktopWebViewScreenState();
}

class _DesktopWebViewScreenState extends State<DesktopWebViewScreen> {
  WebViewController? controller;
  late bool loading;

  @override
  void initState() {
    super.initState();
    loading = true;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WebView(
          initialUrl: widget.url,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController c) {
            setState(() {
              controller = c;
            });
          },
          onPageStarted: (String s) async {
            setState(() {
              // on page started codes
            });
          },
          onPageFinished: (test1) async {
            setState(() {
              loading = false;
            });
            if (widget.isShareProfileScreen) {
              await Future.delayed(
                  Duration(milliseconds: 1000)); // To let complete page load
              if (controller != null) {
                controller!.evaluateJavascript(
                    "(document.getElementsByClassName('share-btn')[3]).click()");
              }
            }
          },
        ),
        loading
            ? Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    ColorConstants.black,
                  ),
                ),
              )
            : SizedBox()
      ],
    );
  }
}
