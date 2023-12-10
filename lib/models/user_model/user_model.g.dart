// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetUserModel _$GetUserModelFromJson(Map<String, dynamic> json) => GetUserModel(
      id: json['id'] as int?,
      phoneNumber: json['phoneNumber'] as String?,
      fio: json['fio'] as String?,
    );

Map<String, dynamic> _$GetUserModelToJson(GetUserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'phoneNumber': instance.phoneNumber,
      'fio': instance.fio,
    };

UserDetailModel _$UserDetailModelFromJson(Map<String, dynamic> json) =>
    UserDetailModel(
      id: json['id'] as int?,
      fio: json['fio'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      imageUrl: json['imageUrl'] as String?,
      roles: (json['roles'] as List<dynamic>?)
          ?.map((e) => RolesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserDetailModelToJson(UserDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fio': instance.fio,
      'phoneNumber': instance.phoneNumber,
      'imageUrl': instance.imageUrl,
      'roles': instance.roles,
    };

RolesModel _$RolesModelFromJson(Map<String, dynamic> json) => RolesModel(
      id: json['id'] as int?,
      roleName: json['roleName'] as String?,
      displayName: json['displayName'] as String?,
    );

Map<String, dynamic> _$RolesModelToJson(RolesModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'roleName': instance.roleName,
      'displayName': instance.displayName,
    };
