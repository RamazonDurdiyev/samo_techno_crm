import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:samo_techno_crm/core/app_const/app_const.dart';
import 'package:samo_techno_crm/core/exceptions/exceptions.dart';
import 'package:samo_techno_crm/core/network/network_info.dart';
import 'package:samo_techno_crm/models/category_model/category_model.dart';
import 'package:samo_techno_crm/models/history_model/history_model.dart';
import 'package:samo_techno_crm/models/product_model/product_model.dart';
import 'package:samo_techno_crm/models/remove_product/remove_product_model.dart';
import 'package:samo_techno_crm/models/unconfirmed_products/unconfirmed_products_model.dart';

class ProductRepo {
  final NetworkInfo networkInfo;
  final Dio client;

  ProductRepo({required this.networkInfo, required this.client});

  Future<List<CategoryModel>> fetchCategories() async {
    if (await networkInfo.isConnected) {
      final res = await client.get(
        GET_ALL_CATEGORIES_API,
      );
      if (kDebugMode) {
        print("fetchCategories data => $res");
      }
      return res.data["data"].map<CategoryModel>(
        (category) {
          return CategoryModel.fromJson(category);
        },
      ).toList();
    } else {
      throw NetworkException();
    }
  }

  Future<HistoryModel> fetchHistories(String placeStatus, int page,) async {
    if (await networkInfo.isConnected) {
      final res = await client.post(FETCH_HISTORIES_API,
          options: Options(
            headers: {"Access-Control-Allow-Origin": ":*"},
          ),
          queryParameters: {"status": placeStatus},
          data: {"page": page, "size": 10,});

      if (kDebugMode) {
        print("fetchHistories data => $res");
      }
      if (kDebugMode) {
        print("HHHHH func called");
      }
      return HistoryModel.fromJson(res.data["data"]);
    } else {
      throw NetworkException();
    }
  }

///////////////////////////////////////////////////////////
//// ************** Fetch history By Id ************* ////
///////////////////////////////////////////////////////////

  Future<HistoryDetailModel> fetchHistoryProductById(
      int id, String placeStatus) async {
    if (await networkInfo.isConnected) {
      final res = await client.get(
        "$FETCH_HISTORY_BY_ID$id",
        queryParameters: {"status": placeStatus},
      );
      if (kDebugMode) {
        print("fetchHistoriesById data => $res");
      }
      return HistoryDetailModel.fromJson(res.data["data"]);
    } else {
      throw NetworkException();
    }
  }

  Future<bool> postProducts(
      List<PostProductModel> newProduct, int tradePlaceId) async {
    if (await networkInfo.isConnected) {
      await client.post(
        POST_PRODUCT_API,
        data: PostProductInfoModel(
                comment: "OK",
                tradePlaceId: tradePlaceId,
                products: newProduct.map((e) => e.toJson()).toList())
            .toJson(),
      );
      return true;
    } else {
      throw NetworkException();
    }
  }

///////////////////////////////////////////////////////////
//// ************** Delete product Id ************* ////
///////////////////////////////////////////////////////////

  Future<bool> deleteProducts(List<DeleteProductModel> productsDelete,
      int tradePlaceId, int contractId) async {
    if (await networkInfo.isConnected) {
      await client.post(
        DELETE_PRODUCTS_API,
        data: DeleteProductInfoModel(
          contractId: 0,
          placeId: tradePlaceId,
          products: productsDelete.map((e) => e.toJson()).toList(),
        ).toJson(),
      );
      return true;
    } else {
      throw NetworkException();
    }
  }

///////////////////////////////////////////////////////////
//// ************** Fetch product By Id ************* /////
///////////////////////////////////////////////////////////

  Future<List<ProductModel>> fetchProductById(int id) async {
    if (await networkInfo.isConnected) {
      final res = await client.get(
        "$GET_PRODUCT_BY_ID$id/all",
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
    } else {
      throw NetworkException();
    }
  }

///////////////////////////////////////////////////////////
//// ******* Fetch product By Id Remove Page ********* ////
///////////////////////////////////////////////////////////

  Future<List<RProductModel>> rFetchProductById(int id) async {
    if (await networkInfo.isConnected) {
      print("r fetch id => $id");
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
    } else {
      throw NetworkException();
    }
  }

///////////////////////////////////////////////////////////
//// *************** Fetch unconfirmeds ************** ////
///////////////////////////////////////////////////////////

  Future<List<UnconfirmedProductsModel>> fetchUnconfirmeds() async {
    if (await networkInfo.isConnected) {
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
    } else {
      throw NetworkException();
    }
  }



  Future<List<UnconfirmedByIdProductsModel>> fetchUnconfirmedById(String status,int transactionId) async {
    if (await networkInfo.isConnected) {
      final res = await client.get(
        "$GET_UNCONFIRMED_PRODUCTS_BYID_API$transactionId",
        queryParameters: {"status":status},
        options: Options(
          headers: {"Access-Control-Allow-Origin": ":*"},
        ),
      );
      if (kDebugMode) {
        print("fetchUncorfirmedById data => $res");
      }
      return res.data["data"].map<UnconfirmedByIdProductsModel>(
        (product) {
          return UnconfirmedByIdProductsModel.fromJson(product);
        },
      ).toList();
    } else {
      throw NetworkException();
    }
  }

}
