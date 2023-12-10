import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:samo_techno_crm/core/app_const/app_const.dart';
import 'package:samo_techno_crm/core/exceptions/exceptions.dart';
import 'package:samo_techno_crm/core/network/network_info.dart';
import 'package:samo_techno_crm/models/user_model/user_model.dart';

class UserRepo {
  final NetworkInfo networkInfo;
  final Dio client;

  UserRepo({required this.networkInfo, required this.client});
  Future<List<GetUserModel>> fetchUsers() async {
    if (await networkInfo.isConnected) {
      final res = await client.get(
        GET_ALL_USERS_API,
      );
      if (kDebugMode) {
        print("fetchUsers data => $res");
      }
      return res.data["data"].map<GetUserModel>(
        (users) {
          return GetUserModel.fromJson(users);
        },
      ).toList();
    } else {
      throw NetworkException();
    }
  }

  Future<bool> addUser(
      String phoneNumber, String password, String fio, String role) async {
    if (await networkInfo.isConnected) {
      await client.post(
        ADD_USER,
        data: {
          "phoneNumber": phoneNumber,
          "password": password,
          "fio": fio,
          "role": role
        },
      );
      return true;
    } else {
      throw NetworkException();
    }
  }

  Future<UserDetailModel> fetchUserById(int id) async {
    if (await networkInfo.isConnected) {
      final res = await client.get(
        "$GET_USER_DETAIL_API$id",
        options: Options(
          headers: {"Access-Control-Allow-Origin": ":*"},
        ),
      );
      if (kDebugMode) {
        print("fetchUser data => $res");
      }
      return UserDetailModel.fromJson(res.data["data"]);
    } else {
      throw NetworkException();
    }
  }

  Future<bool> blocUser(
    int userId,
  ) async {
    if (await networkInfo.isConnected) {
      await client.post(
        BLOC_USER,
        data: {
          "userId": userId,
          "reason": "String",
        },
      );
      return true;
    } else {
      throw NetworkException();
    }
  }

  Future<bool> unBlocUser(
    int userId,
  ) async {
    if (await networkInfo.isConnected) {
      await client.post(
        UNBLOC_USER,
        data: {
          "userId": userId,
          "reason": "String",
        },
      );
      return true;
    } else {
      throw NetworkException();
    }
  }
}
