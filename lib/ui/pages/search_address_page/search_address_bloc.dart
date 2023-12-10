import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide State;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:samo_techno_crm/models/place_model/place_model.dart';
import 'package:samo_techno_crm/repo/place_repo/place_repo.dart';
import 'package:samo_techno_crm/ui/pages/search_address_page/search_address_event.dart';
import 'package:samo_techno_crm/ui/pages/search_address_page/search_address_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchAddressBloc extends Bloc<SearchAddressEvent, SearchAddressState> {
  final PlaceRepo repo;
  SearchAddressBloc({required this.repo}) : super(Initial()) {
    on<ShowToastEvent>((event, emit) async {
      await _showToast(emit);
    });
    on<GetAllPlacesEvent>((event, emit) async {
      await _getAllPlaces(emit, event.status);
    });
    on<SelectAddressEvent>((event, emit) async {
      await _selectAddress(emit, event.place, event.isSell);
    });
    on<SearchPlaceEvent>((event, emit) async {
      await _searchPlace(emit, event.status, event.name);
    });
  }

  // Controllers

  TextEditingController searchAddressCtrl = TextEditingController();

  // Data

  Timer? timer;
  List<PlaceModel> allPlaces = [];
  List<PlaceModel> searchedPlaces = [];

  _showToast(Emitter<SearchAddressState> emit) {
    try {
      emit(ShowToastState(state: State.loading));
      Fluttertoast.showToast(
        msg: "Manzilni tanlang",
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.indigo,
      );
      emit(ShowToastState(state: State.loaded));
    } catch (e) {
      emit(ShowToastState(state: State.error));
    }
  }

  _getAllPlaces(Emitter<SearchAddressState> emit, String status) async {
    try {
      emit(GetAllPlacesState(state: State.loading));
      allPlaces = await repo.fetchAllPlaces(status);
      if (kDebugMode) {
        print("SearchAddressBloc _getAllPlaces places => $allPlaces");
      }
      emit(GetAllPlacesState(state: State.loaded));
    } catch (e) {
      if (kDebugMode) {
        print("SearchAddressBloc _getAllPlaces error => $e");
      }
      emit(GetAllPlacesState(state: State.error));
    }
  }

  _selectAddress(
      Emitter<SearchAddressState> emit, PlaceModel place, bool isSell) async {
    try {
      emit(SelectAddressState(state: State.loading));
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("place", json.encode(place.toJson()));
      prefs.setBool("is_remove", isSell);
      if (kDebugMode) {
        print("SearchAddressBloc _selectAddress addredd saved succesfully");
      }
      emit(SelectAddressState(state: State.loaded));
    } catch (e) {
      if (kDebugMode) {
        print("SearchAddressBloc _selectAddress error => $e");
      }
      emit(SelectAddressState(state: State.error));
    }
  }

  _searchPlace(
      Emitter<SearchAddressState> emit, String status, String name) async {
    try {
      emit(SearchPlaceState(state: State.loading));
      searchedPlaces = searchAddressCtrl.text.isNotEmpty
          ? await repo.fetchPlacesByName(status, name)
          : [];
      if (kDebugMode) {
        print("SearchAddressBloc _searchPlace places => $searchedPlaces");
      }
      emit(SearchPlaceState(state: State.loaded));
    } catch (e) {
      if (kDebugMode) {
        print("SearchAddressBloc _searchPlace error => $e");
      }
      emit(SearchPlaceState(state: State.error));
    }
  }
}
