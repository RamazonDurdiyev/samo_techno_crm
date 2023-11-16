import 'package:json_annotation/json_annotation.dart';
part 'login_data.g.dart';

@JsonSerializable()
class LoginData {
  final int? id;
  final String? fio;
  final String? accessToken;
  final String? refreshToken;

  LoginData({this.id, this.fio, this.accessToken, this.refreshToken});

  factory LoginData.fromJson(Map<String, dynamic> data) =>
      _$LoginDataFromJson(data);

  Map<String, dynamic> toJson() => _$LoginDataToJson(this);
}
