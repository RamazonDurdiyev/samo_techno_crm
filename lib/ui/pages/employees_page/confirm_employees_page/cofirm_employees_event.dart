import 'package:equatable/equatable.dart';

abstract class ConfirmEmployeesEvent extends Equatable {}

class FetchEmployeesEvent extends ConfirmEmployeesEvent {
  @override
  List<Object?> get props => [];
}

class FetchEmployeeByIdEvent extends ConfirmEmployeesEvent {
  final int id;

  FetchEmployeeByIdEvent({required this.id});
  @override
  List<Object?> get props => [id];
}

class BlocUSerEvent extends ConfirmEmployeesEvent {
  final int id;

  BlocUSerEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

class UnBlocUserEvent extends ConfirmEmployeesEvent {
  final int id;

  UnBlocUserEvent({required this.id});
  @override
  List<Object?> get props => [id];
}
