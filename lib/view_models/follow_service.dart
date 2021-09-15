import 'dart:convert';

import 'package:at_contact/at_contact.dart';
import 'package:at_contacts_flutter/utils/init_contacts_service.dart';
import 'package:at_follows_flutter/domain/at_follows_list.dart';
import 'package:at_follows_flutter/utils/at_follow_services.dart';
import 'package:at_wavi_app/common_components/confirmation_dialog.dart';
import 'package:at_wavi_app/model/at_follows_value.dart';
import 'package:at_wavi_app/model/user.dart';
import 'package:at_wavi_app/services/backend_service.dart';
import 'package:at_wavi_app/services/search_service.dart';
import 'package:at_wavi_app/utils/constants.dart';
import 'package:at_wavi_app/view_models/base_model.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:http/http.dart' as http;

class FollowService extends BaseModel {
  FollowService();
  AtFollowsData followers = AtFollowsData();
  AtFollowsData following = AtFollowsData();
  final String FETCH_FOLLOWERS = 'fetch_followers';
  final String FETCH_FOLLOWING = 'fetch_followings';

  init() async {
    await AtFollowServices()
        .initializeFollowService(BackendService().atClientServiceInstance);
    await getFollowers();
    await getFollowing();
    connectionProviderListener();
  }

// listening for updates from at_follows_flutter package.
  connectionProviderListener() async {
    AtFollowServices().connectionProvider.addListener(() async {
      EasyDebounce.debounce('update_follows_data', Duration(milliseconds: 500),
          () async {
        await getFollowers(
            atFollowers: AtFollowServices().connectionService.followers);
        await getFollowing(
            atFollowing: AtFollowServices().connectionService.following);
      });
    });
  }

  getFollowers({AtFollowsList? atFollowers}) async {
    setStatus(FETCH_FOLLOWERS, Status.Loading);
    var followersList = atFollowers == null
        ? AtFollowServices().getFollowersList()
        : atFollowers;

    if (followersList != null) {
      followers.list = followersList.list;
      followers.isPrivate = followersList.isPrivate;
      if (AtFollowServices().getFollowersList()!.getKey != null) {
        followers.setKey = AtFollowServices().getFollowersList()!.getKey!;
      }
      followers.atsignListDetails = <AtsignDetails>[];

      followers.list!.forEach((element) {
        followers.atsignListDetails
            .add(AtsignDetails(atcontact: AtContact(atSign: element)));
      });

      // fetching details of  atsign list
      await fetchAtsignDetails(this.followers.list!);
    }
    setStatus(FETCH_FOLLOWERS, Status.Done);
  }

  getFollowing({AtFollowsList? atFollowing}) async {
    setStatus(FETCH_FOLLOWING, Status.Loading);
    var followingList = atFollowing == null
        ? AtFollowServices().getFollowingList()
        : atFollowing;

    if (followingList != null) {
      following.list = followingList.list;
      following.isPrivate = followingList.isPrivate;
      if (AtFollowServices().getFollowingList()!.getKey != null) {
        following.setKey = AtFollowServices().getFollowingList()!.getKey!;
      }
      following.atsignListDetails = [];

      following.list!.forEach((element) {
        following.atsignListDetails
            .add(AtsignDetails(atcontact: AtContact(atSign: element)));
      });

      // fetching details for  atsign list
      await fetchAtsignDetails(this.following.list!, isFollowing: true);
    }
    setStatus(FETCH_FOLLOWING, Status.Done);
  }

  ///[forFollowersList] is to identify whether we want to perform operation on followers list or following list.
  Future unfollow(String atsign, {bool forFollowersList: false}) async {
    var _choice = await confirmationDialog(atsign);
    if (!_choice) {
      return;
    }

    int index = getIndexOfAtsign(atsign, forFollowersList: forFollowersList);
    // following.atsignListDetails[index].isUnfollowing = true;
    setUnfollowingLoading(index, true);
    notifyListeners();
    try {
      // await Future.delayed(Duration(seconds: 2));
      // print('now unfollowing');
      var result = await AtFollowServices().unfollow(atsign);
      setUnfollowingLoading(index, false);
      notifyListeners();

      if (result) {
        // following.atsignListDetails[index].isUnfollowing = false;
        following.list!.remove(atsign);
        following.atsignListDetails
            .removeWhere((element) => element.atcontact.atSign == atsign);
      } else {
        // following.atsignListDetails[index].isUnfollowing = false;
        // setUnfollowingLoading(index, false);
      }
    } on Error catch (err) {
      print('error in unfollow: $err');
    } on Exception catch (ex) {
      print('exception caugth in unfollow: $ex');
    }
    notifyListeners();
  }

  removeFollower(String atsign) async {
    int index = getIndexOfAtsign(atsign);
    // followers.atsignListDetails[index].isRmovingFromFollowers = true;
    setRemoveFollowerLoading(index, true);
    notifyListeners();
    var res = await AtFollowServices().removeFollower(atsign);
    if (res) {
      followers.list!.remove(atsign);
    } else {
      // followers.atsignListDetails[index].isRmovingFromFollowers = false;
      setRemoveFollowerLoading(index, false);
    }
    notifyListeners();
  }

  Future<List<AtsignDetails>> fetchAtsignDetails(List<String?> atsignList,
      {bool isFollowing = false}) async {
    var atsignDetails = <AtsignDetails>[];

    await Future.forEach(atsignList, (String? atsign) async {
      var atcontact = await getAtSignDetails(atsign!);
      atsignDetails.add(AtsignDetails(atcontact: atcontact));
    });

    if (isFollowing) {
      this.following.atsignListDetails = [...atsignDetails];
    } else {
      this.followers.atsignListDetails = [...atsignDetails];
    }
    return atsignDetails;
  }

  bool isFollowing(String atsign) {
    for (var _atsign in following.list ?? []) {
      if ((atsign == _atsign) || (('@' + atsign) == _atsign)) {
        return true;
      }
    }
    return false;
  }

  ///[forFollowersList] is to identify whether we want to perform operation on followers list or following list.
  performFollowUnfollow(String atsign, {bool forFollowersList: false}) async {
    try {
      bool isFollowingAtsign = isFollowing(atsign);
      if (isFollowingAtsign) {
        await unfollow(atsign, forFollowersList: forFollowersList);
      } else {
        await AtFollowServices().follow(atsign);
      }
      await BackendService().sync();
      await getFollowing();
    } catch (e) {
      print('Error in performFollowUnfollow $e');
    }
  }

  int getIndexOfAtsign(String _atsign, {bool forFollowersList = false}) {
    List _list = forFollowersList ? followers.list! : following.list!;
    for (int i = 0; i < _list.length; i++) {
      if (_list[i] == _atsign) {
        return i;
      }
    }

    return -1;
  }

  setUnfollowingLoading(int index, bool loadingState) {
    if (index > -1) {
      following.atsignListDetails[index].isUnfollowing = loadingState;
    }
  }

  setRemoveFollowerLoading(int index, bool loadingState) {
    if (index > -1) {
      followers.atsignListDetails[index].isRmovingFromFollowers = loadingState;
    }
  }

  getUserFollowsList(String atsign) async {
    try {
      await fetchUserFollowsDataFromApi(atsign);
      followers.atsignListDetails = <AtsignDetails>[];
      following.atsignListDetails = <AtsignDetails>[];
      this.followers.list!.forEach((element) {
        followers.atsignListDetails
            .add(AtsignDetails(atcontact: AtContact(atSign: element)));
      });

      this.following.list!.forEach((element) {
        following.atsignListDetails
            .add(AtsignDetails(atcontact: AtContact(atSign: element)));
      });
      // notify
      print('this.followers.list : ${this.followers.list}');
      print('this.following.list : ${this.following.list}');

      Future.delayed(Duration(seconds: 10), () {
        print('this.followers.list delay : ${this.followers.list}');
        print('this.following.list  delay: ${this.following.list}');
      });
      notifyListeners();
      // await fetchAtsignDetails(this.followers.list!);
      // await fetchAtsignDetails(this.following.list!, isFollowing: true);
    } catch (e) {
      print('error in fetching follows data: ${e}');
    }
  }

  Future<User?> fetchUserFollowsDataFromApi(String atsign) async {
    try {
      List<String> followersList = [];
      List<String> followingList = [];

      var _response =
          await http.get(Uri.parse('${MixedConstants.WAVI_API}$atsign'));

      print('_jsonData ${_response.body}');
      print('_response.statusCode : ${_response.statusCode}');
      // if(_response.statusCode == 200)
      var _jsonData = jsonDecode(_response.body);

      _jsonData.forEach((_data) {
        var _keyValuePair = _data;
        for (var field in _keyValuePair.entries) {
          if (field.key == null) {
            continue;
          }

          if ((field.key.contains(SearchService().followers_key)) ||
              (field.key.contains(SearchService().new_followers_key))) {
            followersList = _keyValuePair[field.key].split(',');
            print('followingList : ${_keyValuePair[field.key]}');
            // followers_count = followersList.length;
            this.followers.list = followersList;

            continue;
          }

          if ((field.key.contains(SearchService().following_key)) ||
              (field.key.contains(SearchService().new_following_key))) {
            followingList = _keyValuePair[field.key].split(',');
            // following_count = followingList.length;
            this.following.list = followingList;

            continue;
          }
        }
      });
    } catch (e) {
      print('Error in $e');
    }
  }
}
