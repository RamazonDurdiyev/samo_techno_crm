import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:samo_techno_crm/core/app_const/app_const.dart';
import 'package:samo_techno_crm/core/exceptions/exceptions.dart';
import 'package:samo_techno_crm/core/network/network_info.dart';
import 'package:samo_techno_crm/models/place_model/place_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlaceRepo {
  final NetworkInfo networkInfo;
  final Dio client;
  final SharedPreferences prefs;

  PlaceRepo({
    required this.networkInfo,
    required this.client,
    required this.prefs,
  });

  Future<List<PlaceModel>> fetchAllPlaces(String status) async {
    if (await networkInfo.isConnected) {
      final res = await client.get(ALL_PLACES_API,
          options: Options(
            headers: {"Access-Control-Allow-Origin": ":*"},
          ),
          queryParameters: {"status": status});
      if (kDebugMode) {
        print("fetchAllPlaces data => $res");
      }
      return res.data["data"].map<PlaceModel>(
        (place) {
          return PlaceModel.fromJson(place);
        },
      ).toList();
    } else {
      throw NetworkException();
    }
  }

  Future<List<PlaceModel>> fetchPlacesByName(String status, String name) async {
    if (await networkInfo.isConnected) {
      print("name $name");
      final res = await client.get(
        "$SEARCH_ADDRESS_API$status/$name",
        options: Options(
          headers: {"Access-Control-Allow-Origin": ":*"},
        ),
      );
      if (kDebugMode) {
        print("fetchPlacesByName data => $res");
      }
      return res.data["data"].map<PlaceModel>(
        (place) {
          return PlaceModel.fromJson(place);
        },
      ).toList();
    } else {
      throw NetworkException();
    }
  }
}
