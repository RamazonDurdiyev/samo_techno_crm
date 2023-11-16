import 'package:equatable/equatable.dart';

abstract class ProductsCartState extends Equatable{}

class Initial extends ProductsCartState{
  @override
  List<Object?> get props => [];
}

class TryToExpandState extends ProductsCartState {
  final State state;

  TryToExpandState({required this.state});
  @override
  List<Object?> get props => [state];
}

class GetLocalProductsState extends ProductsCartState{
  final State state;

  GetLocalProductsState({required this.state});
  @override
  List<Object?> get props => [state];
}

class DeleteLocalProductState extends ProductsCartState{
  final State state;

  DeleteLocalProductState({required this.state});
  @override
  List<Object?> get props => [state];
}

class DeleteAllLocalProductsState extends ProductsCartState{
  final State state;

  DeleteAllLocalProductsState({required this.state});
  @override
  List<Object?> get props => [state];
}

class SortProductsState extends ProductsCartState{
  final State state;

  SortProductsState({required this.state});
  @override
  List<Object?> get props => [state];
}

class PostProductState extends ProductsCartState {
  final State state;

  PostProductState({required this.state});

  @override
  List<Object?> get props => [state];
}


enum State {initial,loading,loaded,error}