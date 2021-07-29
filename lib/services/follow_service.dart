import 'package:at_commons/at_commons.dart';
import 'package:at_contacts_flutter/utils/init_contacts_service.dart';
import 'package:at_wavi_app/model/at_follows_list.dart';
import 'package:at_wavi_app/model/at_follows_value.dart';
import 'package:at_wavi_app/services/backend_service.dart';
import 'package:at_wavi_app/utils/constants.dart';
import 'package:at_wavi_app/view_models/base_model.dart';

class FollowService extends BaseModel {
  FollowService._();
  static final FollowService _instance = FollowService._();
  factory FollowService() => _instance;

  AtFollowsList followers = AtFollowsList();
  AtFollowsList following = AtFollowsList();
  final String FETCH_FOLLOWERS = 'fetch_followers';
  final String FETCH_FOLLOWING = 'fetch_followings';

  Future<void> fetchFollowers() async {
    setStatus(FETCH_FOLLOWERS, Status.Loading);
    var followersValue =
        await BackendService().scanAndGet(MixedConstants.followers);
    this.followers.create(followersValue);
    fetchAtsignDetails(this.followers.list!);
    setStatus(FETCH_FOLLOWERS, Status.Done);
  }

  Future<void> fetchFollowings() async {
    setStatus(FETCH_FOLLOWING, Status.Loading);
    var followingValue =
        await BackendService().scanAndGet(MixedConstants.following);
    this.following.create(followingValue);
    fetchAtsignDetails(this.following.list!, isFollowing: true);
    setStatus(FETCH_FOLLOWING, Status.Done);
  }

  Future unfollow(String? atsign, int index) async {
    following.atsignDetails[index].isUnfollowing = true;
    notifyListeners();
    try {
      var result = await _unfollow(atsign);
      if (result) {
        following.list!.remove(atsign);
        following.atsignDetails
            .removeWhere((element) => element.atcontact.atSign == atsign);
      } else {
        following.atsignDetails[index].isUnfollowing = false;
      }
    } on Error catch (err) {
      print('error in unfollow: $err');
    } on Exception catch (ex) {
      print('exception caugth in unfollow: $ex');
    }
    notifyListeners();
  }

  Future<bool> _unfollow(String? atsign) async {
    atsign = BackendService().formatAtSign(atsign);
    var atKey = this._formKey(isFollowing: true);
    var result = await _modifyKey(atsign, this.following, atKey);
    notifyListeners();
    return result;
  }

  removeFollower(String atsign, int index) async {
    followers.atsignDetails[index].isRmovingFromFollowers = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 10));
    var atkey = _formKey();
    var followersList = followers.getKey!.value.split(',');
    followersList.remove(atsign);
    var res = await BackendService().put(
        atkey, followersList.isNotEmpty ? followersList.toString() : 'null');
    if (res) {
      followers.list!.remove(atsign);
    } else {
      followers.atsignDetails[index].isRmovingFromFollowers = false;
    }
    notifyListeners();
  }

  Future<bool> _modifyKey(
      String? atsign, AtFollowsList atFollowsList, AtKey atKey) async {
    var result = false;
    if (!atFollowsList.list!.contains(atsign)) {
      return false;
    }
    atFollowsList.remove(atsign);
    if (atFollowsList.toString().isEmpty) {
      result = await BackendService().put(atKey, 'null');
    } else {
      result = await BackendService().put(atKey, atFollowsList.toString());
    }
    return result;
  }

  AtKey _formKey({bool isFollowing = false, String? atsign}) {
    var atKey;
    var atSign = atsign ?? BackendService().currentAtSign;
    if (isFollowing) {
      var atMetadata = Metadata()..isPublic = !following.isPrivate;
      atKey = AtKey()
        ..metadata = atMetadata
        ..key = MixedConstants.following
        ..sharedWith = atMetadata.isPublic! ? null : atSign;
    } else {
      var atMetadata = Metadata()..isPublic = !followers.isPrivate;
      atKey = AtKey()
        ..metadata = atMetadata
        ..key = MixedConstants.followers
        ..sharedWith = atMetadata.isPublic! ? null : atSign;
    }
    return atKey;
  }

  Future<List<AtsignDetails>> fetchAtsignDetails(List<String?> atsignList,
      {bool isFollowing = false}) async {
    var atsignDetails = <AtsignDetails>[];

    await Future.forEach(atsignList, (String? atsign) async {
      var atcontact = await getAtSignDetails(atsign!);
      atsignDetails.add(AtsignDetails(atcontact: atcontact));
    });

    if (isFollowing) {
      this.following.atsignDetails = atsignDetails;
    } else {
      this.followers.atsignDetails = atsignDetails;
    }
    notifyListeners();
    return atsignDetails;
  }
}
