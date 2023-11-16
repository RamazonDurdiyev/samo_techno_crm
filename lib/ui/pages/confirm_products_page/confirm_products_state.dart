import 'package:equatable/equatable.dart';

abstract class ConfirmProductsState extends Equatable{}

class Initial extends ConfirmProductsState{
  @override
  List<Object?> get props => [];
}


class FetchUnconfirmedsState extends ConfirmProductsState{
  final State state;

  FetchUnconfirmedsState({required this.state});
  @override
  List<Object?> get props => [state];
}

enum State {initial,loading,loaded,error}