import 'package:dio/dio.dart';
import 'package:samo_techno_crm/core/app_const/app_const.dart';
import 'package:samo_techno_crm/models/login_data/login_data.dart';

class LoginRepo {
  final Dio client = Dio();

   Future<LoginData> login(String phone,String password) async {
    // if (await networkInfo.isConnected) {
      final ref = await client.post(
        LOGIN_API,
        data: {"phone":phone,"password":password}
      );
        return LoginData.fromJson(ref.data["data"]);
    
    // } else {
    //   throw NetworkException();
    // }
  }

  Future<LoginData> refresh(String refreshToken) async {
    // if (await networkInfo.isConnected) {
      final ref = await client.post(
        REFRESH_TOKEN_API,
        data: {"refreshToken": refreshToken},
      );
      return LoginData.fromJson(ref.data);
    // } else {
    //   throw NetworkException();
    // }
  }
}
