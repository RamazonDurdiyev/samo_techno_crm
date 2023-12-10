import 'package:equatable/equatable.dart';
import 'package:samo_techno_crm/models/cart_product/cart_product_model.dart';

abstract class RemoveProductEvent extends Equatable {}

class ChangeTabEvent extends RemoveProductEvent {
  final int value;

  ChangeTabEvent({required this.value});
  @override
  List<Object?> get props => [value];
}

class TryToExpandEvent extends RemoveProductEvent {
  final int index;

  TryToExpandEvent({required this.index});
  @override
  List<Object?> get props => [index];
}

class FetchCategoriesEvent extends RemoveProductEvent {
  @override
  List<Object?> get props => [];
}

class FetchCategoryByIdEvent extends RemoveProductEvent{
  final int id;

  FetchCategoryByIdEvent({required this.id});
  @override
  List<Object?> get props => [id];
}

class SaveLocalToCartEvent extends RemoveProductEvent{
  final CartProductModel product;

  SaveLocalToCartEvent({required this.product});
  @override
  List<Object?> get props => [product];
}