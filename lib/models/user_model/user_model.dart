import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class GetUserModel {
  final int? id;
  final String? phoneNumber;
  final String? fio;

  GetUserModel({this.id, this.phoneNumber, this.fio});

  factory GetUserModel.fromJson(Map<String, dynamic> data) =>
      _$GetUserModelFromJson(data);

  Map<String, dynamic> toJson() => _$GetUserModelToJson(this);
}

@JsonSerializable()
class UserDetailModel {
  final int? id;
  final String? fio;
  final String? phoneNumber;
  final String? imageUrl;
  final List<RolesModel>? roles;

  UserDetailModel({
    this.id,
    this.fio,
    this.phoneNumber,
    this.imageUrl,
    this.roles,
  });

  factory UserDetailModel.fromJson(Map<String, dynamic> data) =>
      _$UserDetailModelFromJson(data);

  Map<String, dynamic> toJson() => _$UserDetailModelToJson(this);
}

@JsonSerializable()
class RolesModel {
  final int? id;
  final String? roleName;
  final String? displayName;

  RolesModel({
    this.id,
    this.roleName,
    this.displayName,
  });

  factory RolesModel.fromJson(Map<String, dynamic> data) =>
      _$RolesModelFromJson(data);

  Map<String, dynamic> toJson() => _$RolesModelToJson(this);
}
