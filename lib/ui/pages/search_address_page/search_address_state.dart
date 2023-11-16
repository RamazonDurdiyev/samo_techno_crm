import 'package:equatable/equatable.dart';

abstract class SearchAddressState extends Equatable {}

class Initial extends SearchAddressState {
  @override
  List<Object?> get props => [];
}

class ShowToastState extends SearchAddressState {
  final State state;

  ShowToastState({required this.state});
  @override
  List<Object?> get props => [];
}

enum State { initial, loading, loaded, error }
