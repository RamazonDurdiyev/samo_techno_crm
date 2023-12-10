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

class GetAllPlacesState extends SearchAddressState{
  final State state;

  GetAllPlacesState({required this.state});
  @override
  List<Object?> get props => [state];
}

class SelectAddressState extends SearchAddressState{
  final State state;

  SelectAddressState({required this.state});
  @override
  List<Object?> get props => [state];
}

class SearchPlaceState extends SearchAddressState{
  final State state;

  SearchPlaceState({required this.state});
  @override
  List<Object?> get props => [state];
}

enum State { initial, loading, loaded, error }
