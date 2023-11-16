import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:samo_techno_crm/core/app_const/app_const.dart';
import 'package:samo_techno_crm/models/product_model/product_model.dart';

class ProductRepo {
  final Dio client = Dio();

  Future<bool> postProducts(List<PostProductModel> newProduct) async {
    // if (await networkInfo.isConnected) {
    await client.post(
      queryParameters: {"tradePlaceId": 1, "comment": "nima"},
      POST_PRODUCT_API,
      data: newProduct.map((product) => product.toJson()).toList(),
    );
    return true;
    // } else {
    // throw NetworkException();
    // }
  }


///////////////////////////////////////////////////////////
//// ************** Delete product By Id ************* ////
///////////////////////////////////////////////////////////

    Future<bool> deleteProducts(List<DeleteProductModel> productDelete) async {
    // if (await networkInfo.isConnected) {
    await client.post(
      queryParameters: {"tradePlaceId": 2, "comment": "nima"},
      DELETE_PRODUCTS_API,
      data: productDelete.map((product) => product.toJson()).toList(),
    );
    return true;
    // } else {
    // throw NetworkException();
    // }
  }

  
///////////////////////////////////////////////////////////
//// ************** Fetch product By Id ************* /////
///////////////////////////////////////////////////////////

Future <List<ProductModel>> fetchProductById(int id) async {
    // if (await networkInfo.isConnected) {
      final res = await client.get(
        "$GET_PRODUCT_BY_ID$id",
        options: Options(
          headers: {"Access-Control-Allow-Origin": ":*"},
        ),
      );
      if (kDebugMode) {
        print("fetchCategories data => $res");
      }
      return res.data["data"].map<ProductModel>(
        (product) {
          return ProductModel.fromJson(product);
        },
      ).toList();
    // } else {
    //   throw NetworkException();
    // }
  }

///////////////////////////////////////////////////////////
//// ******* Fetch product By Id Remove Page ********* ////
///////////////////////////////////////////////////////////

Future <List<RProductModel>> rFetchProductById(int id) async {
    // if (await networkInfo.isConnected) {
      final res = await client.get(
        "$REMOVE_GET_PRODUCT_BY_ID$id",
        options: Options(
          headers: {"Access-Control-Allow-Origin": ":*"},
        ),
      );
      if (kDebugMode) {
        print("fetchCategories data => $res");
      }
      return res.data["data"].map<RProductModel>(
        (product) {
          return RProductModel.fromJson(product);
          
        },
      ).toList();
    // } else {
    //   throw NetworkException();
    // }
  }


///////////////////////////////////////////////////////////
//// *************** Fetch unconfirmeds ************** ////
///////////////////////////////////////////////////////////

    Future<List<UnconfirmedProductsModel>> fetchUnconfirmeds() async {
    // if (await networkInfo.isConnected) {
      final res = await client.get(
        GET_UNCONFIRMED_PRODUCTS_API,
        options: Options(
          headers: {"Access-Control-Allow-Origin": ":*"},
        ),
      );
      if (kDebugMode) {
        print("fetchUnconfirmeds data => $res");
      }
      return res.data["data"].map<UnconfirmedProductsModel>(
        (product) {
          return UnconfirmedProductsModel.fromJson(product);
        },
      ).toList();
    // } else {
    //   throw NetworkException();
    // }
  }
}
