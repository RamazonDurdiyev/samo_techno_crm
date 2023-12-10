import 'package:equatable/equatable.dart';

abstract class ConfirmEmployeesState extends Equatable {}

class Initial extends ConfirmEmployeesState {
  @override
  List<Object?> get props => [];
}

class FetchEmployeesState extends ConfirmEmployeesState {
  final State state;
  FetchEmployeesState({required this.state});
  @override
  List<Object?> get props => [state];
}

class FetchEmployeeByIdState extends ConfirmEmployeesState {
  final State state;

  FetchEmployeeByIdState({required this.state});
  @override
  List<Object?> get props => [state];
}

class BlocUserState extends ConfirmEmployeesState {
  final State state;

  BlocUserState({required this.state});
  @override
  List<Object?> get props => [state];
}

class UnBlocUserState extends ConfirmEmployeesState {
  final State state;

  UnBlocUserState({required this.state});
  @override
  List<Object?> get props => [state];
}

enum State { initial, loading, loaded, error }
