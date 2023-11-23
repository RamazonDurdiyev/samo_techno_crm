import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:samo_techno_crm/core/app_const/app_const.dart';
import 'package:samo_techno_crm/core/exceptions/exceptions.dart';
import 'package:samo_techno_crm/core/network/network_info.dart';
import 'package:samo_techno_crm/models/login_data/login_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginRepo {
  final NetworkInfo networkInfo;
  final Dio client;
  final SharedPreferences prefs;

  LoginRepo({
    required this.networkInfo,
    required this.client,
    required this.prefs,
  });

  Future<LoginData> login(String phone, String password) async {
    if (await networkInfo.isConnected) {
      final ref = await client
          .post(LOGIN_API, data: {"phone": phone, "password": password});
      await prefs.setString(
        "user",
        json.encode(
          ref.data["data"],
        ),
      );
      return LoginData.fromJson(ref.data["data"]);
    } else {
      throw NetworkException();
    }
  }

  Future<LoginData> refresh(String refreshToken) async {
    if (await networkInfo.isConnected) {
      print(
          "${refreshToken}++++++++++++++++========================++++++++++++++++++++++ refresh token function in repo");
      final ref = await client.post(
        REFRESH_TOKEN_API,
        data: {"refreshToken": refreshToken},
      );
      print("REFRESH called++++++++++++++++++++++++++++++++++++++++");
      // print("new token equals to last token ${refreshToken == }")
      return LoginData.fromJson(ref.data["data"]);
    } else {
      throw NetworkException();
    }
  }
}
