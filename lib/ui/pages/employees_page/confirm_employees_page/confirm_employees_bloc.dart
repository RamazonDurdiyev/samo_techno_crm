import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samo_techno_crm/models/user_model/user_model.dart';
import 'package:samo_techno_crm/repo/user_repo/user_repo.dart';
import 'package:samo_techno_crm/ui/pages/employees_page/confirm_employees_page/cofirm_employees_event.dart';
import 'package:samo_techno_crm/ui/pages/employees_page/confirm_employees_page/confirm_employees_state.dart';

class ConfirmEmployeesBloc
    extends Bloc<ConfirmEmployeesEvent, ConfirmEmployeesState> {
  final UserRepo repo;
  ConfirmEmployeesBloc({required this.repo}) : super(Initial()) {
    on<FetchEmployeesEvent>((event, emit) async {
      await _fetchEmployees(emit);
    });
    on<FetchEmployeeByIdEvent>((event, emit) async {
      await _fetchCategoryById(emit, event.id);
    });
    on<BlocUSerEvent>(
      (event, emit) async {
        await _blocUser(emit, event.id);
      },
    );
    on<UnBlocUserEvent>(
      (event, emit) async {
        await _unBlocUser(emit, event.id);
      },
    );
  }

  ///Data
  List<GetUserModel> users = [];
  UserDetailModel employeesById = UserDetailModel();

  _fetchEmployees(Emitter<ConfirmEmployeesState> emit) async {
    try {
      emit(FetchEmployeesState(state: State.loading));
      users = await repo.fetchUsers();
      print(" users${users.length} length");
      if (kDebugMode) {
        print("ConfirmEmployeesBloc _fetchUsers users => $users");
      }
      emit(FetchEmployeesState(state: State.loaded));
    } catch (e) {
      emit(FetchEmployeesState(state: State.error));
      if (kDebugMode) {
        print("ConfirmEmloyeesBloc _fetchUsers error => $e");
      }
    }
  }

  _fetchCategoryById(Emitter<ConfirmEmployeesState> emit, int id) async {
    try {
      emit(FetchEmployeeByIdState(state: State.loading));
      employeesById = await repo.fetchUserById(id);
      print("display${employeesById.roles?.first.displayName ?? ""}");
      if (kDebugMode) {
        print(
            "ConfirmEmployeesBloc _fetchEmployeeById employeeById products => $employeesById");
      }
      emit(FetchEmployeeByIdState(state: State.loaded));
    } catch (e) {
      emit(FetchEmployeeByIdState(state: State.error));
      if (kDebugMode) {
        print("ConfirmEmployeesBloc _fetchEmployeeById error => $e");
      }
    }
  }

  _blocUser(Emitter<ConfirmEmployeesState> emit, int id) async {
    try {
      emit(BlocUserState(state: State.loading));
      await repo.blocUser(id);
      emit(BlocUserState(state: State.loaded));
    } catch (e) {
      emit(BlocUserState(state: State.error));
      if (kDebugMode) {
        print("ConfirmEmployeesBloc =>blocUser function error=> $e");
      }
    }
  }

  _unBlocUser(Emitter<ConfirmEmployeesState> emit, int id) async {
    try {
      emit(UnBlocUserState(state: State.loading));
      await repo.unBlocUser(id);
      emit(UnBlocUserState(state: State.loaded));
    } catch (e) {
      emit(UnBlocUserState(state: State.error));
      if (kDebugMode) {
        print("ConfirmEmployeesBloc =>UnblocUser function error=> $e");
      }
    }
  }
}
