import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide State;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:samo_techno_crm/models/cart_product/cart_product_model.dart';
import 'package:samo_techno_crm/models/category_model/category_model.dart';
import 'package:samo_techno_crm/models/remove_product/remove_product_model.dart';
import 'package:samo_techno_crm/repo/product_repo/product_repo.dart';
import 'package:samo_techno_crm/ui/pages/remove_products_page/remove_products_event.dart';
import 'package:samo_techno_crm/ui/pages/remove_products_page/remove_products_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RemoveProductBloc extends Bloc<RemoveProductEvent, RemoveProductState> {
  final ProductRepo repo;
  RemoveProductBloc({required this.repo}) : super(Initial()) {
    on<ChangeTabEvent>((event, emit) async {
      await _changeTab(emit, event.value);
    });
    on<TryToExpandEvent>((event, emit) async {
      await _tryToExpand(emit, event.index);
    });
    on<FetchCategoriesEvent>((event, emit) async {
      await _fetchCategories(emit);
    });
    on<FetchCategoryByIdEvent>((event, emit) async {
      await _fetchCategoryById(emit, event.id);
    });
    on<SaveLocalToCartEvent>((event, emit) async {
      await _saveLocalToCart(emit, event.product);
    });
  }

  // Controllers

  TextEditingController searchProductCtrl = TextEditingController();
  TextEditingController contractCtrl = TextEditingController();
  TextEditingController countCtrl = TextEditingController();

  // Data

  List<CategoryModel> categoriesList = [];
  List<String> localProducts = [];
  List<RProductModel> productsById = [];
  int currentIndexOfTab = 0;
  bool isSell = true;
  String contractId = "";
  List<bool> isExpandedItems = List.filled(1000, false);

  _changeTab(Emitter<RemoveProductState> emit, int value) async {
    try {
      emit(ChangeTabState(state: State.loading));
      currentIndexOfTab = value;
      emit(ChangeTabState(state: State.loaded));
    } catch (e) {
      emit(ChangeTabState(state: State.error));
    }
  }

  _tryToExpand(Emitter<RemoveProductState> emit, int index) {
    try {
      emit(TryToExpandState(state: State.loading));
      isExpandedItems[index] = !isExpandedItems[index];
      emit(TryToExpandState(state: State.loaded));
    } catch (e) {
      emit(TryToExpandState(state: State.error));
    }
  }

  _fetchCategories(Emitter<RemoveProductState> emit) async {
    try {
      emit(AddFetchCategoriesState(state: State.loading));
      final prefs = await SharedPreferences.getInstance();
      isSell = prefs.getBool("is_remove") ?? true;
      contractId = prefs.getString("contract_id") ?? "";
      categoriesList = await repo.fetchCategories();

      if (kDebugMode) {
        print(
            "RemoveProductBloc _fetchCategories categoriesList => $categoriesList");
      }
      emit(AddFetchCategoriesState(state: State.loaded));
    } catch (e) {
      emit(AddFetchCategoriesState(state: State.error));
      if (kDebugMode) {
        print("RemoveProductBloc _fetchCategories error => $e");
      }
    }
  }

  _saveLocalToCart(
      Emitter<RemoveProductState> emit, CartProductModel product) async {
    try {
      emit(SaveLocalToCartState(state: State.loading));
      if (contractCtrl.text.isNotEmpty == true || contractId.isNotEmpty) {
        final prefs = await SharedPreferences.getInstance();
        localProducts = prefs.getStringList("cart_products") ?? [];
        prefs
            .setString("contract_id", contractCtrl.text)
            .then((value) => contractId = prefs.getString("contract_id") ?? "");
        if (localProducts.contains(json.encode(product.toJson())) != true) {
          localProducts.add(json.encode(product.toJson()));
          prefs.setStringList(
            "cart_products",
            localProducts,
          );
          Fluttertoast.showToast(
            msg: "Added succesfully",
            backgroundColor: Colors.indigo,
            textColor: Colors.white,
          );
        } else {
          Fluttertoast.showToast(
            msg: "Already exist",
            backgroundColor: Colors.red,
            textColor: Colors.white,
          );
        }
      } else {
        Fluttertoast.showToast(
          msg: "Kontrakt raqami kiritilmagan!",
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
      emit(SaveLocalToCartState(state: State.loaded));
    } catch (e) {
      emit(SaveLocalToCartState(state: State.error));
      if (kDebugMode) {
        print("RemoveProductBloc _saveLocalToCart error => $e");
      }
    }
  }

  _fetchCategoryById(Emitter<RemoveProductState> emit, int id) async {
    try {
      emit(FetchCategoryByIdState(state: State.loading));
      final prefs = await SharedPreferences.getInstance();
      productsById = await repo.rFetchProductById(id);
      contractId = prefs.getString("contract_id") ?? "";
      if (kDebugMode) {
        print(
            "RemoveProductBloc _fetchCategoryById categoryById products => $productsById");
      }
      emit(FetchCategoryByIdState(state: State.loaded));
    } catch (e) {
      emit(FetchCategoryByIdState(state: State.error));
      if (kDebugMode) {
        print("RemoveProductBloc _fetchCategoryById error => $e");
      }
    }
  }
}
