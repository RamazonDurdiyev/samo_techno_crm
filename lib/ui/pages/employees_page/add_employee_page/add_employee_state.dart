import 'package:equatable/equatable.dart';

abstract class AddEmployeeState extends Equatable {}

class Initial extends AddEmployeeState {
  @override
  List<Object?> get props => [];
}

class PostUserState extends AddEmployeeState {
  final State state;

  PostUserState({required this.state});
  @override
  List<Object?> get props => [state];
}

enum State { initial, loading, loaded, error }
