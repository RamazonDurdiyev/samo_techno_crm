// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartProductModel _$CartProductModelFromJson(Map<String, dynamic> json) =>
    CartProductModel(
      productId: json['productId'] as int?,
      name: json['name'] as String?,
      categoryName: json['categoryName'] as String?,
      inProductId: json['inProductId'] as int?,
      quantity: json['quantity'] as int?,
      price: (json['price'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CartProductModelToJson(CartProductModel instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'name': instance.name,
      'categoryName': instance.categoryName,
      'inProductId': instance.inProductId,
      'quantity': instance.quantity,
      'price': instance.price,
    };

CartInProductModel _$CartInProductModelFromJson(Map<String, dynamic> json) =>
    CartInProductModel(
      inproductId: json['inproductId'] as int?,
      quantity: json['quantity'] as int?,
      price: (json['price'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CartInProductModelToJson(CartInProductModel instance) =>
    <String, dynamic>{
      'inproductId': instance.inproductId,
      'quantity': instance.quantity,
      'price': instance.price,
    };
