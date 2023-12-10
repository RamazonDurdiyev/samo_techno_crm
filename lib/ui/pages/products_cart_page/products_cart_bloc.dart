import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide State;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:samo_techno_crm/models/cart_product/cart_product_model.dart';
import 'package:samo_techno_crm/models/place_model/place_model.dart';
import 'package:samo_techno_crm/models/product_model/product_model.dart';
import 'package:samo_techno_crm/models/remove_product/remove_product_model.dart';
import 'package:samo_techno_crm/repo/product_repo/product_repo.dart';
import 'package:samo_techno_crm/ui/pages/products_cart_page/products_cart_event.dart';
import 'package:samo_techno_crm/ui/pages/products_cart_page/products_cart_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductsCartBloc extends Bloc<ProductsCartEvent, ProductsCartState> {
  final ProductRepo repo;
  ProductsCartBloc({required this.repo}) : super(Initial()) {
    on<TryToExpandEvent>((event, emit) async {
      await _tryToExpand(emit, event.index);
    });
    on<GetLocalProductsEvent>((event, emit) async {
      await _getLocalProducts(emit);
    });
    on<DeleteLocalProductEvent>((event, emit) async {
      await _deleteLocalProduct(emit, event.product);
    });
    on<SortProductsEvent>((event, emit) async {
      await _sortProducts(emit, event.categoryName);
    });
    on<PostProductEvent>(
      (event, emit) async {
        await _postProduct(emit, event.newProducts);
      },
    );
    on<DeleteProductEvent>(
      (event, emit) async {
        await _deleteProduct(emit, event.productDelete);
      },
    );
    on<DeleteAllLocalProductsEvent>((event, emit) async {
      await _deleteAllLocalProducts(emit);
    });
  }

  // Controllers

  TextEditingController countCtrl = TextEditingController();

  // Data

  bool isSell = false;
  List isItemExpanded = List.filled(20, false);
  List<String> localProducts = [];
  List categoryNames = [];
  List<String> sortProducts = [];
  String selectedPlace = "";
  String contractId = "";

  _tryToExpand(Emitter<ProductsCartState> emit, int index) {
    try {
      emit(TryToExpandState(state: State.loading));
      List trueItems =
          isItemExpanded.where((element) => element == true).toList();
      if (trueItems.length == 1 && isItemExpanded[index] != true) {
        isItemExpanded = List.filled(20, false);
      }
      isItemExpanded[index] = !isItemExpanded[index];
      emit(TryToExpandState(state: State.loaded));
    } catch (e) {
      emit(TryToExpandState(state: State.error));
    }
  }

  _getLocalProducts(Emitter<ProductsCartState> emit) async {
    try {
      emit(GetLocalProductsState(state: State.loading));
      final prefs = await SharedPreferences.getInstance();
      localProducts = prefs.getStringList("cart_products") ?? [];
      selectedPlace = prefs.getString("place") ?? "";
      isSell = prefs.getBool("is_remove") ?? false;
      contractId = prefs.getString("contract_id") ?? "";
      for (var i = 0; i < localProducts.length; i++) {
        if (!categoryNames.contains(
            CartProductModel.fromJson(json.decode(localProducts[i]))
                .categoryName)) {
          categoryNames.add(
              CartProductModel.fromJson(json.decode(localProducts[i]))
                  .categoryName);
        }
      }
      if (kDebugMode) {
        print(
            "ProductsCartBloc _getLocalProducts localProducts => $localProducts");
      }
      emit(GetLocalProductsState(state: State.loaded));
    } catch (e) {
      emit(GetLocalProductsState(state: State.error));
      if (kDebugMode) {
        print("ProductsCartBloc _getLocalProducts error => $e");
      }
    }
  }

  _deleteLocalProduct(
      Emitter<ProductsCartState> emit, CartProductModel product) async {
    try {
      emit(DeleteLocalProductState(state: State.loading));
      final prefs = await SharedPreferences.getInstance();
      localProducts = prefs.getStringList("cart_products") ?? [];
      localProducts.remove(json.encode(product.toJson()));
      sortProducts.remove(json.encode(product.toJson()));
      categoryNames = [];
      for (var i = 0; i < localProducts.length; i++) {
        if (!categoryNames.contains(
            CartProductModel.fromJson(json.decode(localProducts[i]))
                .categoryName)) {
          categoryNames.add(
              CartProductModel.fromJson(json.decode(localProducts[i]))
                  .categoryName);
        }
      }
      prefs.setStringList("cart_products", localProducts);
      if (localProducts.isEmpty) {
        prefs.remove("is_remove");
        prefs.remove("place");
      }
      if (kDebugMode) {
        print(
            "ProductsCartBloc _deleteLocalProducts product deleted succesfully");
      }
      Fluttertoast.showToast(
        msg: "O`chirildi",
        backgroundColor: Colors.indigo,
        textColor: Colors.white,
      );
      emit(DeleteLocalProductState(state: State.loaded));
    } catch (e) {
      emit(DeleteLocalProductState(state: State.error));
      if (kDebugMode) {
        print("ProductsCartBloc _deleteLocalProducts error => $e");
      }
    }
  }

  _sortProducts(Emitter<ProductsCartState> emit, String categoryName) async {
    try {
      emit(SortProductsState(state: State.loading));
      final prefs = await SharedPreferences.getInstance();
      sortProducts = prefs.getStringList("cart_products") ?? [];
      sortProducts.removeWhere((product) {
        return CartProductModel.fromJson(json.decode(product)).categoryName !=
            categoryName;
      });
      emit(SortProductsState(state: State.loaded));
    } catch (e) {
      emit(SortProductsState(state: State.error));
      if (kDebugMode) {
        print("ProductsCartBloc _sortProducts error => $e");
      }
    }
  }

  _postProduct(
      Emitter<ProductsCartState> emit, List<PostProductModel> products) async {
    try {
      emit(PostProductState(state: State.loading));
      repo
          .postProducts(
              products, PlaceModel.fromJson(json.decode(selectedPlace)).id!);
          

      if (kDebugMode) {
        print("ProductsCartBloc _postProducts posted succesfully");
      }
      emit(PostProductState(state: State.loaded));
    } catch (e) {
      emit(PostProductState(state: State.error));
      if (kDebugMode) {
        print("ProductsCartBloc _postProducts error => $e");
      }
    }
  }

  _deleteProduct(Emitter<ProductsCartState> emit,
      List<DeleteProductModel> products) async {
    try {
      emit(DeleteProductState(state: State.loading));
      repo
          .deleteProducts(
              products,
              PlaceModel.fromJson(json.decode(selectedPlace)).id!,
              int.parse(contractId),);
          
           

      if (kDebugMode) {
        print("ProductsCartBloc _deleteProducts deleted succesfully");
      }
      emit(DeleteProductState(state: State.loaded));
    } catch (e) {
      emit(DeleteProductState(state: State.error));
      if (kDebugMode) {
        print("ProductsCartBloc _deleteProducts error => $e");
      }
    }
  }

  _deleteAllLocalProducts(Emitter<ProductsCartState> emit) async {
    try {
      emit(DeleteAllLocalProductsState(state: State.loading));
      final prefs = await SharedPreferences.getInstance();
      localProducts = [];
      sortProducts = [];
      prefs.remove("place");
      prefs.remove("cart_products");
      prefs.remove("is_remove");
      prefs.remove("contract_id");
      if (kDebugMode) {
        print(
            "ProductsCartBloc _deleteAllLocalProducts all products deleted succesfully");
      }
      Fluttertoast.showToast(
        msg: "Barcha ma`lumot o`chirildi",
        backgroundColor: Colors.indigo,
        gravity: ToastGravity.BOTTOM,
      );
      emit(DeleteAllLocalProductsState(state: State.loaded));
    } catch (e) {
      emit(DeleteAllLocalProductsState(state: State.error));
      if (kDebugMode) {
        print("ProductsCartBloc _deleteAllLocalProducts error => $e");
      }
    }
  }
}
