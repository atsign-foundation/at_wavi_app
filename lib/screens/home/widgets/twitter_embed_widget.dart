import 'dart:convert';

import 'package:at_wavi_app/services/size_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TwitterEmbedWidget extends StatelessWidget {
  final String twitterUsername;

  final String twitterEmbedText = '''
<!DOCTYPE html>
<html>
   <head>
      <title>Page Title</title>
   </head>
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <body>
      <a class="twitter-timeline" href="https://twitter.com/{username}?ref_src=twsrc%5Etfw">Tweets by {username}</a> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
   </body>
</html>
''';

  const TwitterEmbedWidget({
    Key? key,
    required this.twitterUsername,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final url = Uri.dataFromString(
            twitterEmbedText.replaceAll('{username}', twitterUsername),
            mimeType: 'text/html',
            encoding: Encoding.getByName('utf-8'))
        .toString();
    return Container(
      height: 200.toHeight,
      child: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        gestureRecognizers: Set()
          ..add(Factory<OneSequenceGestureRecognizer>(
              () => EagerGestureRecognizer())),
        onWebViewCreated: (controller) {
          controller.loadUrl(url);
        },
        navigationDelegate: (NavigationRequest request) {
          if (request.url == url) {
            return NavigationDecision.navigate;
          } else {
            return NavigationDecision.prevent;
          }
        },
      ),
    );
  }
}
