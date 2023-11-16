import 'package:equatable/equatable.dart';

abstract class RemoveProductState extends Equatable {}

class Initial extends RemoveProductState {
  @override
  List<Object?> get props => [];
}

class ChangeTabState extends RemoveProductState {
  final State state;

  ChangeTabState({required this.state});
  @override
  List<Object?> get props => [state];
}

class TryToExpandState extends RemoveProductState {
  final State state;

  TryToExpandState({required this.state});
  @override
  List<Object?> get props => [state];
}

class AddFetchCategoriesState extends RemoveProductState {
  final State state;

  AddFetchCategoriesState({required this.state});
  @override
  List<Object?> get props => [state];
}

class FetchCategoryByIdState extends RemoveProductState{
  final State state;

  FetchCategoryByIdState({required this.state});
  @override
  List<Object?> get props => [state];
}

class SaveLocalToCartState extends RemoveProductState {
  final State state;

  SaveLocalToCartState({required this.state});
  @override
  List<Object?> get props => [state];
}

enum State { initial, loading, loaded, error }
