import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide State;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:samo_techno_crm/models/cart_product/cart_product_model.dart';
import 'package:samo_techno_crm/models/category_model/category_model.dart';
import 'package:samo_techno_crm/models/product_model/product_model.dart';
import 'package:samo_techno_crm/repo/product_repo/product_repo.dart';
import 'package:samo_techno_crm/ui/pages/add_product_page/add_product_event.dart';
import 'package:samo_techno_crm/ui/pages/add_product_page/add_product_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddProductBloc extends Bloc<AddProductEvent, AddProductState> {
  final ProductRepo repo;
  AddProductBloc({required this.repo}) : super(Initial()) {
    on<ChangeTabEvent>((event, emit) async {
      await _changeTab(emit, event.value);
    });
    on<TryToExpandEvent>((event, emit) async {
      await _tryToExpand(emit, event.index);
    });
    on<AddFetchCategoriesEvent>((event, emit) async {
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
  TextEditingController costCtrl = TextEditingController();
  TextEditingController countCtrl = TextEditingController();

  // Data
  List<CategoryModel> categoriesList = [];
  List<String> localProducts = [];
  List<ProductModel> productsById = [];
  int currentIndexOfTab = 0;
  List<bool> isExpandedItems = List.filled(1000, false);
  bool isSell = false;

  _changeTab(Emitter<AddProductState> emit, int value) async {
    try {
      emit(ChangeTabState(state: State.loading));
      currentIndexOfTab = value;
      emit(ChangeTabState(state: State.loaded));
    } catch (e) {
      emit(ChangeTabState(state: State.error));
    }
  }

  _tryToExpand(Emitter<AddProductState> emit, int index) {
    try {
      emit(TryToExpandState(state: State.loading));
      isExpandedItems[index] = !isExpandedItems[index];
      emit(TryToExpandState(state: State.loaded));
    } catch (e) {
      emit(TryToExpandState(state: State.error));
    }
  }

  _fetchCategories(Emitter<AddProductState> emit) async {
    try {
      emit(AddFetchCategoriesState(state: State.loading));
      final prefs = await SharedPreferences.getInstance();
      isSell = prefs.getBool("is_remove") ?? false;
      categoriesList = await repo.fetchCategories();
      if (kDebugMode) {
        print(
            "AddProductBloc _fetchCategories categoriesList => $categoriesList");
      }
      emit(AddFetchCategoriesState(state: State.loaded));
    } catch (e) {
      emit(AddFetchCategoriesState(state: State.error));
      if (kDebugMode) {
        print("AddProductBloc _fetchCategories error => $e");
      }
    }
  }

  _saveLocalToCart(
      Emitter<AddProductState> emit, CartProductModel product) async {
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
        Fluttertoast.showToast(
          msg: "Muvaffaqiyatli",
          backgroundColor: Colors.indigo,
          textColor: Colors.white,
        );
      } else {
        Fluttertoast.showToast(
          msg: "Savatda mavjud",
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
      emit(SaveLocalToCartState(state: State.loaded));
    } catch (e) {
      emit(SaveLocalToCartState(state: State.error));
      if (kDebugMode) {
        print("AddProductBloc _saveLocalToCart error => $e");
      }
    }
  }

  _fetchCategoryById(Emitter<AddProductState> emit, int id) async {
    try {
      emit(FetchCategoryByIdState(state: State.loading));
      productsById = await repo.fetchProductById(id);
      if (kDebugMode) {
        print(
            "AddProductBloc _fetchCategoryById categoryById products => $productsById");
      }
      emit(FetchCategoryByIdState(state: State.loaded));
    } catch (e) {
      emit(FetchCategoryByIdState(state: State.error));
      if (kDebugMode) {
        print("AddProductBloc _fetchCategoryById error => $e");
      }
    }
  }
}
