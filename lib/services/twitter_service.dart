import 'dart:convert';

import 'package:at_wavi_app/model/twitter.dart';
import 'package:at_wavi_app/utils/constants.dart';
import 'package:at_wavi_app/view_models/user_provider.dart';
import 'package:http/http.dart' as http;

class TwitetrService {
  TwitetrService._();
  static final TwitetrService _instance = TwitetrService._();
  factory TwitetrService() => _instance;
  TwitterUser? twitterUser;
  List<Tweet> tweetList = [];

  final String twitterEndpoint = 'https://api.twitter.com/2/';

  getTweets() async {
    String? username;
    if (UserProvider().user != null && UserProvider().user!.twitter != null) {
      username = UserProvider().user!.twitter.value;
    }
    //TODO: for testing only
    // username = 'geekyants';
    if (username == null) {
      return;
    }
    await getTwitterUser(username);
    if (twitterUser!.id != null) {
      await getTwitterRecentPosts(twitterUser!.id!);
    }
  }

  Future<TwitterUser> getTwitterUser(String username) async {
    ;
    var headers = {
      'Authorization': 'Bearer ${MixedConstants.twitterBearerToken}',
    };
    var request = http.Request(
        'GET', Uri.parse('${twitterEndpoint}users/by/username/$username'));

    request.headers.addAll(headers);
    var response = await request.send();

    if (response.statusCode == 200) {
      var responseString = await response.stream.bytesToString();
      var user = jsonDecode(responseString);
      twitterUser = TwitterUser.fromJson(user['data']);
      return twitterUser!;
    } else {
      twitterUser = TwitterUser(null, null, null);
      return twitterUser!;
    }
  }

  Future<List<Tweet>> getTwitterRecentPosts(String id) async {
    tweetList = [];
    var headers = {
      'Authorization': 'Bearer ${MixedConstants.twitterBearerToken}',
    };
    var request =
        http.Request('GET', Uri.parse('${twitterEndpoint}users/$id/tweets'));

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responseString = await response.stream.bytesToString();
      var tweets = jsonDecode(responseString);
      if (tweets['data'] != null) {
        tweets['data'].forEach((el) {
          tweetList.add(Tweet.fromJson(el)!);
        });
      }
      return tweetList;
    } else {
      return [];
    }
  }
}
