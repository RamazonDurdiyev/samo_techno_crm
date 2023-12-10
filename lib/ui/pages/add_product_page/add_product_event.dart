import 'package:equatable/equatable.dart';
import 'package:samo_techno_crm/models/cart_product/cart_product_model.dart';

abstract class AddProductEvent extends Equatable {}

class ChangeTabEvent extends AddProductEvent {
  final int value;

  ChangeTabEvent({required this.value});
  @override
  List<Object?> get props => [value];
}

class TryToExpandEvent extends AddProductEvent {
  final int index;

  TryToExpandEvent({required this.index});
  @override
  List<Object?> get props => [index];
}

class AddFetchCategoriesEvent extends AddProductEvent {
  @override
  List<Object?> get props => [];
}

class FetchCategoryByIdEvent extends AddProductEvent{
  final int id;

  FetchCategoryByIdEvent({required this.id});
  @override
  List<Object?> get props => [id];
}

class SaveLocalToCartEvent extends AddProductEvent{
  final CartProductModel product;

  SaveLocalToCartEvent({required this.product});
  @override
  List<Object?> get props => [product];
}