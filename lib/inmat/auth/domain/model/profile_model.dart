import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_model.g.dart';

part 'profile_model.freezed.dart';

// $ flutter pub run build_runner build

@freezed
class ProfileModel with _$ProfileModel {
  factory ProfileModel({
 required int index,
    required  String email,
    required  String nickname,
    required String profile,
    required String created,
  }) = _ProfileModel;

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);
}

