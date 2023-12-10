import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide State;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samo_techno_crm/repo/user_repo/user_repo.dart';
import 'package:samo_techno_crm/ui/pages/employees_page/add_employee_page/add_employee_event.dart';
import 'package:samo_techno_crm/ui/pages/employees_page/add_employee_page/add_employee_state.dart';

class AddEmployeeBloc extends Bloc<AddEmployeeEvent, AddEmployeeState> {
  final UserRepo repo;
  AddEmployeeBloc({required this.repo}) : super(Initial()) {
    on<PostUserEvent>((event, emit) async {
      await _postUsers(emit);
    });
  }

  ////////////////// Controllers/////////////////////
  TextEditingController phoneNumberCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController fioCtrl = TextEditingController();
  TextEditingController roleCtrl = TextEditingController();

  _postUsers(Emitter<AddEmployeeState> emit) async {
    try {
      emit(PostUserState(state: State.loading));
      await repo.addUser(
          phoneNumberCtrl.text, passwordCtrl.text, fioCtrl.text, roleCtrl.text);
      emit(PostUserState(state: State.loaded));
    } catch (e) {
      emit(PostUserState(state: State.error));
      if (kDebugMode) {
        print("AddEmployeeBloc =>postUser function error=> $e");
      }
    }
  }
}
