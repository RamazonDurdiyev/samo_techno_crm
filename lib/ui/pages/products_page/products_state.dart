import 'package:equatable/equatable.dart';

abstract class ProductsState extends Equatable {}

class Initial extends ProductsState {
  @override
  List<Object?> get props => [];
}

class ChangeTabState extends ProductsState {
  final State state;

  ChangeTabState({required this.state});
  @override
  List<Object?> get props => [state];
}

class TryToExpandState extends ProductsState {
  final State state;

  TryToExpandState({required this.state});
  @override
  List<Object?> get props => [state];
}

class AddFetchCategoriesState extends ProductsState {
  final State state;

  AddFetchCategoriesState({required this.state});
  @override
  List<Object?> get props => [state];
}

class FetchCategoryByIdState extends ProductsState {
  final State state;

  FetchCategoryByIdState({required this.state});
  @override
  List<Object?> get props => [state];
}

class SaveLocalToCartState extends ProductsState {
  final State state;

  SaveLocalToCartState({required this.state});
  @override
  List<Object?> get props => [state];
}

enum State { initial, loading, loaded, error }
