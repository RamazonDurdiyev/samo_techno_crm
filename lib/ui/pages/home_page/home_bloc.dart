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
  }

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
}
