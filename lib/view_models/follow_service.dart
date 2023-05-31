import 'package:at_commons/at_commons.dart';
import 'package:at_contact/at_contact.dart';
import 'package:at_contacts_flutter/utils/init_contacts_service.dart';
import 'package:at_follows_flutter/domain/at_follows_list.dart';
import 'package:at_follows_flutter/utils/at_follow_services.dart';
import 'package:at_server_status/at_server_status.dart';
import 'package:at_wavi_app/common_components/confirmation_dialog.dart';
import 'package:at_wavi_app/desktop/utils/snackbar_utils.dart';
import 'package:at_wavi_app/model/at_follows_value.dart';
import 'package:at_wavi_app/services/backend_service.dart';
import 'package:at_wavi_app/view_models/base_model.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../services/nav_service.dart';

class FollowService extends BaseModel {
  FollowService();
  AtFollowsData followers = AtFollowsData();
  AtFollowsData following = AtFollowsData();
  final String FETCH_FOLLOWERS = 'fetch_followers';
  final String FETCH_FOLLOWING = 'fetch_followings';

  late AtStatus atStatus;
  final AtStatusImpl atStatusImpl = AtStatusImpl();

  // AtStatus atStatus = await atStatusImpl.get(atSign);
  // AtSignStatus atSignStatus = atStatus.status();
  // int httpStatus = atStatus.httpStatus();

  bool isFollowersFetched = false;
  bool isFollowingFetched = false;

  Future<void> init() async {
    try {
      await AtFollowServices()
          .initializeFollowService(BackendService().atClientServiceInstance);
      connectionProviderListener();
    } catch (e) {
      print('error in follows package init : ${e}');
      connectionProviderListener();
    }
  }

  resetData() {
    followers = AtFollowsData();
    following = AtFollowsData();
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

      // TODO: optimize
      // fetching details of  atsign list
      // await fetchAtsignDetails(this.followers.list!);
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

      // TODO: optimize
      // fetching details for  atsign list
      // await fetchAtsignDetails(this.following.list!, isFollowing: true);
    }
    setStatus(FETCH_FOLLOWING, Status.Done);
  }

  ///[forFollowersList] is to identify whether we want to perform operation on followers list or following list.
  Future unfollow(String atsign, {bool forFollowersList: false}) async {
    var _choice = await confirmationDialog(atsign);
    if ((_choice == null) || !_choice) {
      return;
    }

    int index = getIndexOfAtsign(atsign, forFollowersList: forFollowersList);
    // following.atsignListDetails[index].isUnfollowing = true;
    setUnfollowingLoading(index, true);
    notifyListeners();
    try {
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

    for (int i = 0; i < atsignList.length; i++) {
      var atcontact = await getAtSignDetails(atsignList[i]!);
      if (isFollowing) {
        this.following.atsignListDetails[i] =
            AtsignDetails(atcontact: atcontact);
      } else {
        this.followers.atsignListDetails[i] =
            AtsignDetails(atcontact: atcontact);
      }
      notifyListeners();
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
  Future<void> performFollowUnfollow(String atsign,
      {bool forFollowersList: false}) async {
    // check for the atsign we are about to follow is valid or not
    atStatus = await atStatusImpl.get(atsign);
    if (atStatus.serverLocation == null) {
      print('Invalid atSign');
      await ScaffoldMessenger.of(NavService.navKey.currentContext!)
          .showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "Invalid atsign",
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
      return;
    }
    try {
      bool isFollowingAtsign = isFollowing(atsign);
      if (isFollowingAtsign) {
        await unfollow(atsign, forFollowersList: forFollowersList);
      } else {
        await AtFollowServices().follow(atsign);
      }
      // BackendService().sync();
      // await getFollowing();
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

  addFollowersData(AtValue atValue) async {
    if (atValue.value == null || atValue.value == 'null') return;
    List<String> followersList = atValue.value.split(',');
    this.followers.list = followersList;
    isFollowersFetched = true;
    this.followers.list!.forEach((element) {
      followers.atsignListDetails
          .add(AtsignDetails(atcontact: AtContact(atSign: element)));
    });
  }

  addFollowingData(AtValue atValue) async {
    if (atValue.value == null || atValue.value == 'null') return;
    List<String> followingList = atValue.value.split(',');
    this.following.list = followingList;
    isFollowingFetched = true;
    this.following.list!.forEach((element) {
      following.atsignListDetails
          .add(AtsignDetails(atcontact: AtContact(atSign: element)));
    });
  }
}
