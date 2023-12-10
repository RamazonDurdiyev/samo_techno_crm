import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {}

class Initial extends HomeState {
  @override
  List<Object?> get props => [];
}

class RemoveUserState extends HomeState{
  final State state;

  RemoveUserState({required this.state});
  @override
  List<Object?> get props => [state];
}


class CheckAddressSelectedState extends HomeState{
  final State state;

  CheckAddressSelectedState({required this.state});
  @override
  List<Object?> get props => [state];
}

class RemoveAddressState extends HomeState{
  final State state;

  RemoveAddressState({required this.state});
  @override
  List<Object?> get props => [state];
}


enum State {initial,loading,loaded,error}


