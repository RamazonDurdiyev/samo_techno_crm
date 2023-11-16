import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:samo_techno_crm/core/app_const/app_const.dart';
import 'package:samo_techno_crm/core/network/network_interceptor.dart';
import 'package:samo_techno_crm/models/category_model/category_model.dart';

class CategoryRepo {
  // final NetworkInfo networkInfo;
   var client = Dio();
   
  

  // CategoryRepo({
  //   // required this.networkInfo,
  // });

  Future<List<CategoryModel>> fetchCategories() async {
    client = addInterceptor(client);
    // if (await networkInfo.isConnected) {
      final res = await client.get(
        GET_ALL_CATEGORIES_API,
        options: Options(
          headers: {"Access-Control-Allow-Origin": ":*"},
        ),
      );
      if (kDebugMode) {
        print("fetchCategories data => $res");
      }
      return res.data["data"].map<CategoryModel>(
        (category) {
          return CategoryModel.fromJson(category);
        },
      ).toList();
    // } else {
    //   throw NetworkException();
    // }
  }
}
