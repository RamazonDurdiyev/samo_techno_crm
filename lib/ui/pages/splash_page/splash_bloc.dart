import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samo_techno_crm/ui/pages/splash_page/splash_event.dart';
import 'package:samo_techno_crm/ui/pages/splash_page/splash_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(Initial()) {
    on<CheckUserEvent>((event, emit) async {
      await _checkUser(emit);
    });
  }

  // Data

  String user = "";

  _checkUser(Emitter<SplashState> emit) async {
    try {
      emit(CheckUserState(state: State.loading));
      final prefs = await SharedPreferences.getInstance();
      user = prefs.getString("user") ?? "";
      if (kDebugMode) {
        print("SplashBloc _checkUser => $user");
      }
      emit(CheckUserState(state: State.loaded));
    } catch (e) {
      if (kDebugMode) {
        print("SplashBloc _checkUser error => $e");
      }
      emit(CheckUserState(state: State.error));
    }
  }
}
