import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samo_techno_crm/ui/pages/home_page/home_event.dart';
import 'package:samo_techno_crm/ui/pages/home_page/home_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(Initial()) {
    on<RemoveUserEvent>((event, emit) async {
      await _removeUser(emit);
    });
    on<CheckAddressSelectedEvent>((event, emit) async {
      await _checkAddressSelected(emit);
    });
    on<RemoveAddressEvent>((event, emit) async {
      await _removeAddress(emit);
    });
  }

  // Data

  String selectedAddress = "";
  bool? isSell;

  _removeUser(Emitter<HomeState> emit) async {
    try {
      emit(RemoveUserState(state: State.loading));
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("user", "");
      if (kDebugMode) {
        print("HomeBloc _removeUser user removed succesfully");
      }
      emit(RemoveUserState(state: State.loaded));
    } catch (e) {
      if (kDebugMode) {
        print("HomeBloc _removeUser error => $e");
      }
      emit(RemoveUserState(state: State.error));
    }
  }

  _checkAddressSelected(Emitter<HomeState> emit) async {
    try {
      emit(CheckAddressSelectedState(state: State.loading));
      final prefs = await SharedPreferences.getInstance();
      selectedAddress = prefs.getString("place") ?? "";
      isSell = prefs.getBool("is_remove");
      if (kDebugMode) {
        print(
            "HomeBloc _checkAddressSelected selectedAddress => $selectedAddress");
      }
      emit(CheckAddressSelectedState(state: State.loaded));
    } catch (e) {
      if (kDebugMode) {
        print("SearchAddressBloc _checkAddressSelected error => $e");
        emit(CheckAddressSelectedState(state: State.error));
      }
    }
  }

  _removeAddress(Emitter<HomeState> emit) async {
    try {
      emit(RemoveAddressState(state: State.loading));
      final prefs = await SharedPreferences.getInstance();
      selectedAddress = "";
      prefs.setString("place", "");
      prefs.remove("is_remove");
      prefs.remove("cart_products");
      prefs.remove("contract_id");
      emit(RemoveAddressState(state: State.loaded));
    } catch (e) {
      emit(RemoveAddressState(state: State.error));
    }
  }
}
