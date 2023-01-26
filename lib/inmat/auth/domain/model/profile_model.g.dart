// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ProfileModel _$$_ProfileModelFromJson(Map<String, dynamic> json) =>
    _$_ProfileModel(
      index: json['index'] as int,
      email: json['email'] as String,
      nickname: json['nickname'] as String,
      profile: json['profile'] as String,
      created: json['created'] as String,
    );

Map<String, dynamic> _$$_ProfileModelToJson(_$_ProfileModel instance) =>
    <String, dynamic>{
      'index': instance.index,
      'email': instance.email,
      'nickname': instance.nickname,
      'profile': instance.profile,
      'created': instance.created,
    };
