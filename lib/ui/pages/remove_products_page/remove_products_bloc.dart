import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide State;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:samo_techno_crm/models/category_model/category_model.dart';
import 'package:samo_techno_crm/models/product_model/product_model.dart';
import 'package:samo_techno_crm/repo/category_repo/category_repo.dart';
import 'package:samo_techno_crm/repo/product_repo/product_repo.dart';
import 'package:samo_techno_crm/ui/pages/remove_products_page/remove_products_event.dart';
import 'package:samo_techno_crm/ui/pages/remove_products_page/remove_products_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RemoveProductBloc extends Bloc<RemoveProductEvent, RemoveProductState> {
  RemoveProductBloc () : super(Initial()) {
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
  CategoryRepo repo = CategoryRepo();
  ProductRepo productRepo = ProductRepo();
  List<CategoryModel> categoriesList = [];
  List<String> localProducts = [];
  List<RProductModel> productsById = [];
  int currentIndexOfTab = 0;
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
      final prefs = await SharedPreferences.getInstance();
      localProducts = prefs.getStringList("cart_products") ?? [];
      if (localProducts.contains(json.encode(product.toJson())) != true) {
        localProducts.add(json.encode(product.toJson()));
        prefs.setStringList(
          "cart_products",
          localProducts,
        );
        prefs.setBool("is_remove", true);
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
      productsById = await productRepo.rFetchProductById(id);
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
