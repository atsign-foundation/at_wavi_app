import 'package:at_wavi_app/model/at_follows_list.dart';
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
    setStatus(FETCH_FOLLOWERS, Status.Done);
  }

  Future<void> fetchFollowings() async {
    setStatus(FETCH_FOLLOWING, Status.Loading);
    var followingValue =
        await BackendService().scanAndGet(MixedConstants.following);
    this.following.create(followingValue);
    setStatus(FETCH_FOLLOWING, Status.Done);
  }
}
