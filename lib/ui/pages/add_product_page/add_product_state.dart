import 'package:equatable/equatable.dart';

abstract class AddProductState extends Equatable {}

class Initial extends AddProductState {
  @override
  List<Object?> get props => [];
}

class ChangeTabState extends AddProductState {
  final State state;

  ChangeTabState({required this.state});
  @override
  List<Object?> get props => [state];
}

class TryToExpandState extends AddProductState {
  final State state;

  TryToExpandState({required this.state});
  @override
  List<Object?> get props => [state];
}

class AddFetchCategoriesState extends AddProductState {
  final State state;

  AddFetchCategoriesState({required this.state});
  @override
  List<Object?> get props => [state];
}

class FetchCategoryByIdState extends AddProductState{
  final State state;

  FetchCategoryByIdState({required this.state});
  @override
  List<Object?> get props => [state];
}

class SaveLocalToCartState extends AddProductState {
  final State state;

  SaveLocalToCartState({required this.state});
  @override
  List<Object?> get props => [state];
}

enum State { initial, loading, loaded, error }
