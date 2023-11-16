import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:samo_techno_crm/core/app_const/app_const.dart';
import 'package:samo_techno_crm/models/history_model/history_model.dart';

class HistoryRepo {
  Dio client = Dio();

   Future<List<HistoryModel>> fetchHistories() async {
    // if (await networkInfo.isConnected) {
      final res = await client.get(
        FETCH_HISTORIES_API,
        options: Options(
          headers: {"Access-Control-Allow-Origin": ":*"},
        ),
      );
      if (kDebugMode) {
        print("fetchHistories data => $res");
      }
      return res.data["data"].map<HistoryModel>(
        (history) {
          return HistoryModel.fromJson(history);
        },
      ).toList();
    // } else {
    //   throw NetworkException();
    // }
  }

///////////////////////////////////////////////////////////
//// ************** Fetch history By Id ************* ////
///////////////////////////////////////////////////////////

Future<List<HistoryDetailModel>> fetchHistoryProductById(int id) async {
    // if (await networkInfo.isConnected) {
    final res = await client.get(
      "$FETCH_HISTORY_BY_ID$id",
      options: Options(
        
        headers: {"Access-Control-Allow-Origin": ":*"},
      ),
    );
    if (kDebugMode) {
      print("fetchHistoriesById data => $res");
    }
    return res.data["data"].map<HistoryDetailProductModel>(
      (product) {
        return HistoryDetailProductModel.fromJson(product);
      },
    ).toList();
    // } else {
    //   throw NetworkException();
    // }
  }

}