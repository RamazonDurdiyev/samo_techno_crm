// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remove_product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RProductModel _$RProductModelFromJson(Map<String, dynamic> json) =>
    RProductModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      imageUrl: json['imageUrl'] as String?,
      totalPrice: (json['totalPrice'] as num?)?.toDouble(),
      totalNumber: json['totalNumber'] as int?,
      children: (json['children'] as List<dynamic>?)
          ?.map((e) => RProductItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RProductModelToJson(RProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'totalPrice': instance.totalPrice,
      'totalNumber': instance.totalNumber,
      'children': instance.children,
    };

RProductItemModel _$RProductItemModelFromJson(Map<String, dynamic> json) =>
    RProductItemModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      quantity: json['quantity'] as int?,
      prices: (json['prices'] as List<dynamic>?)
          ?.map((e) => ProductPricesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RProductItemModelToJson(RProductItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'quantity': instance.quantity,
      'prices': instance.prices,
    };

ProductPricesModel _$ProductPricesModelFromJson(Map<String, dynamic> json) =>
    ProductPricesModel(
      inproductId: json['inproductId'] as int?,
      quantity: json['quantity'] as int?,
      price: (json['price'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ProductPricesModelToJson(ProductPricesModel instance) =>
    <String, dynamic>{
      'inproductId': instance.inproductId,
      'quantity': instance.quantity,
      'price': instance.price,
    };

DeleteProductInfoModel _$DeleteProductInfoModelFromJson(
        Map<String, dynamic> json) =>
    DeleteProductInfoModel(
      placeId: json['placeId'] as int?,
      contractId: json['contractId'] as int?,
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
    );

Map<String, dynamic> _$DeleteProductInfoModelToJson(
        DeleteProductInfoModel instance) =>
    <String, dynamic>{
      'placeId': instance.placeId,
      'contractId': instance.contractId,
      'products': instance.products,
    };

DeleteProductModel _$DeleteProductModelFromJson(Map<String, dynamic> json) =>
    DeleteProductModel(
      productId: json['productId'] as int?,
      inProductId: json['inProductId'] as int?,
      quantity: json['quantity'] as int?,
      price: (json['price'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$DeleteProductModelToJson(DeleteProductModel instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'inProductId': instance.inProductId,
      'quantity': instance.quantity,
      'price': instance.price,
    };

DeleteInProductModel _$DeleteInProductModelFromJson(
        Map<String, dynamic> json) =>
    DeleteInProductModel(
      inproductId: json['inproductId'] as int?,
      quantity: json['quantity'] as int?,
      price: (json['price'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$DeleteInProductModelToJson(
        DeleteInProductModel instance) =>
    <String, dynamic>{
      'inproductId': instance.inproductId,
      'quantity': instance.quantity,
      'price': instance.price,
    };
