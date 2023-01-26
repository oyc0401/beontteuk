import 'domain/model/profile_model.dart';
import 'domain/model/token_model.dart';

class User {
  User({
    required this.profileModel,
    required this.tokenModel,
  });

  final ProfileModel profileModel;
  final TokenModel tokenModel;

  String get email => profileModel.email;

  String get created => profileModel.created;

  String get nickname => profileModel.nickname;

  String? get profile => profileModel.profile;

  String get token => '${tokenModel.user_id}';

  @override
  String toString() {
    return "User (email: $email, nickname: $nickname, profile: $profile, created: $created)";
  }
}
