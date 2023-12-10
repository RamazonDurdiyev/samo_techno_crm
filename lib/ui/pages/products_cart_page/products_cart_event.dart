import 'package:equatable/equatable.dart';
import 'package:samo_techno_crm/models/cart_product/cart_product_model.dart';
import 'package:samo_techno_crm/models/product_model/product_model.dart';
import 'package:samo_techno_crm/models/remove_product/remove_product_model.dart';

abstract class ProductsCartEvent extends Equatable{}

class TryToExpandEvent extends ProductsCartEvent {
  final int index;

  TryToExpandEvent({required this.index});
  @override
  List<Object?> get props => [index];
}

class GetLocalProductsEvent extends ProductsCartEvent{
  @override
  List<Object?> get props => [];
}

class DeleteLocalProductEvent extends ProductsCartEvent{
 final CartProductModel product;

  DeleteLocalProductEvent({required this.product});
  @override
  List<Object?> get props => [product];
}

class DeleteAllLocalProductsEvent extends ProductsCartEvent{
  @override
  List<Object?> get props => [];
}

class SortProductsEvent extends ProductsCartEvent{
  final String categoryName;

  SortProductsEvent({ required this.categoryName});
  @override
  List<Object?> get props => [categoryName];
}

class PostProductEvent extends ProductsCartEvent {
  final List<PostProductModel> newProducts;

  PostProductEvent({required this.newProducts});
  @override
  List<Object?> get props => [newProducts];
}

class DeleteProductEvent extends ProductsCartEvent {
  final List<DeleteProductModel> productDelete;

  DeleteProductEvent({required this.productDelete});
  @override
  List<Object?> get props => [productDelete];
}