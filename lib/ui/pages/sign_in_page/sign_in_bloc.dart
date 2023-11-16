import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide State;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samo_techno_crm/models/login_data/login_data.dart';
import 'package:samo_techno_crm/repo/login_repo/login_repo.dart';

import 'sign_in_event.dart';
import 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(Initial()) {
    on((event, emit) async {
      await _login(emit);
    });
  }

  // Controllers

  TextEditingController phoneCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

  // Data

  GlobalKey<FormState> passwordKey = GlobalKey();
  bool isUserAvailable = false;
  LoginData user = LoginData();
  LoginRepo repo = LoginRepo();

  _login(Emitter<SignInState> emit) async {
    try {
      emit(LoginState(state: State.loading));
      user = await repo.login(phoneCtrl.text, passwordCtrl.text);
      if (kDebugMode) {
        print("SignInBloc _login user => ${user.id}");
      }
      if (user.id != null) {
        isUserAvailable = true;
      }
      emit(LoginState(state: State.loaded));
    } catch (e) {
      if (kDebugMode) {
        print("SignInBloc _login error => $e");
      }
      emit(LoginState(state: State.error));
    }
  }
}
