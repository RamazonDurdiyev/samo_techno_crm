import 'package:equatable/equatable.dart';
import 'package:samo_techno_crm/models/product_model/product_model.dart';

abstract class ProductsEvent extends Equatable {}

class ChangeTabEvent extends ProductsEvent {
  final int value;

  ChangeTabEvent({required this.value});
  @override
  List<Object?> get props => [value];
}

class TryToExpandEvent extends ProductsEvent {
  final int index;

  TryToExpandEvent({required this.index});
  @override
  List<Object?> get props => [index];
}

class FetchCategoriesEvent extends ProductsEvent {
  @override
  List<Object?> get props => [];
}

class FetchCategoryByIdEvent extends ProductsEvent {
  final int id;

  FetchCategoryByIdEvent({required this.id});
  @override
  List<Object?> get props => [id];
}

class SaveLocalToCartEvent extends ProductsEvent {
  final CartProductModel product;

  SaveLocalToCartEvent({required this.product});
  @override
  List<Object?> get props => [product];
}
