import 'package:at_contact/at_contact.dart';
import 'package:at_contacts_flutter/utils/init_contacts_service.dart';
import 'package:at_follows_flutter/utils/at_follow_services.dart';
import 'package:at_wavi_app/model/at_follows_value.dart';
import 'package:at_wavi_app/services/backend_service.dart';
import 'package:at_wavi_app/view_models/base_model.dart';

class FollowService extends BaseModel {
  // FollowService._();
  // static final FollowService _instance = FollowService._();
  // factory FollowService() => _instance;

  AtFollowsData followers = AtFollowsData();
  AtFollowsData following = AtFollowsData();
  final String FETCH_FOLLOWERS = 'fetch_followers';
  final String FETCH_FOLLOWING = 'fetch_followings';

  init() async {
    await AtFollowServices()
        .initializeFollowService(BackendService().atClientServiceInstance);
    await getFollowers();
    await getFollowing();
  }

  getFollowers() async {
    setStatus(FETCH_FOLLOWERS, Status.Loading);
    var followersList = AtFollowServices().getFollowersList();
    if (followersList != null) {
      followers.list = followersList.list;
      followers.isPrivate = followersList.isPrivate;

      followers.list!.forEach((element) {
        followers.atsignListDetails
            .add(AtsignDetails(atcontact: AtContact(atSign: element)));
      });

      // fetching details of  atsign list
      await fetchAtsignDetails(this.followers.list!);
    }
    setStatus(FETCH_FOLLOWERS, Status.Done);
  }

  getFollowing() async {
    setStatus(FETCH_FOLLOWING, Status.Loading);
    var followingList = AtFollowServices().getFollowingList();
    if (followingList != null) {
      following.list = followingList.list;
      following.isPrivate = followingList.isPrivate;

      following.list!.forEach((element) {
        following.atsignListDetails
            .add(AtsignDetails(atcontact: AtContact(atSign: element)));
      });

      // fetching details for  atsign list
      await fetchAtsignDetails(this.following.list!, isFollowing: true);
    }
    setStatus(FETCH_FOLLOWING, Status.Done);
  }

  Future unfollow(String atsign, int index) async {
    following.atsignListDetails[index].isUnfollowing = true;
    notifyListeners();
    try {
      var result = await AtFollowServices().unfollow(atsign);

      if (result) {
        following.list!.remove(atsign);
        following.atsignListDetails
            .removeWhere((element) => element.atcontact.atSign == atsign);
        following.atsignListDetails[index].isUnfollowing = false;
      } else {
        following.atsignListDetails[index].isUnfollowing = false;
      }
    } on Error catch (err) {
      print('error in unfollow: $err');
    } on Exception catch (ex) {
      print('exception caugth in unfollow: $ex');
    }
    notifyListeners();
  }

  removeFollower(String atsign, int index) async {
    followers.atsignListDetails[index].isRmovingFromFollowers = true;
    notifyListeners();
    var res = await AtFollowServices().removeFollower(atsign);
    if (res) {
      followers.list!.remove(atsign);
    } else {
      followers.atsignListDetails[index].isRmovingFromFollowers = false;
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
      this.following.atsignListDetails = atsignDetails;
    } else {
      this.followers.atsignListDetails = atsignDetails;
    }
    notifyListeners();
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

  performFollowUnfollow(String atsign, {bool? isFollowingAtsign}) async {
    try {
      if (isFollowingAtsign == null) {
        isFollowingAtsign = isFollowing(atsign);
      }
      if (isFollowingAtsign) {
        await unfollow(
            atsign,
            ((following.list ?? []).indexOf(atsign) < 0
                ? 0
                : (following.list ?? []).indexOf(atsign)));
      } else {
        await AtFollowServices().follow(atsign);
        await getFollowers();
      }
    } catch (e) {
      print('Error in performFollowUnfollow $e');
    }
  }
}
