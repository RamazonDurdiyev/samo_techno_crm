// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      imageUrl: json['imageUrl'] as String?,
      children: (json['children'] as List<dynamic>?)
          ?.map((e) => ProductItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'children': instance.children,
    };

DeleteProductModel _$DeleteProductModelFromJson(Map<String, dynamic> json) =>
    DeleteProductModel(
      outContractNumber: json['outContractNumber'] as int?,
      sellPlaceId: json['sellPlaceId'] as int?,
      inProductId: json['inProductId'] as int?,
      quantity: json['quantity'] as int?,
    );

Map<String, dynamic> _$DeleteProductModelToJson(DeleteProductModel instance) =>
    <String, dynamic>{
      'outContractNumber': instance.outContractNumber,
      'sellPlaceId': instance.sellPlaceId,
      'inProductId': instance.inProductId,
      'quantity': instance.quantity,
    };

RProductModel _$RProductModelFromJson(Map<String, dynamic> json) =>
    RProductModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      totalPrice: json['totalPrice'] as int?,
      totalNumber: json['totalNumber'] as int?,
      children: (json['children'] as List<dynamic>?)
          ?.map((e) => RProductItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RProductModelToJson(RProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
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
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$RProductItemModelToJson(RProductItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'quantity': instance.quantity,
      'imageUrl': instance.imageUrl,
    };

ProductItemModel _$ProductItemModelFromJson(Map<String, dynamic> json) =>
    ProductItemModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$ProductItemModelToJson(ProductItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
    };

CartProductModel _$CartProductModelFromJson(Map<String, dynamic> json) =>
    CartProductModel(
      productId: json['productId'] as int?,
      outContractNumber: json['outContractNumber'] as int?,
      sellPlaceId: json['sellPlaceId'] as int?,
      inProductId: json['inProductId'] as int?,
      categoryName: json['categoryName'] as String?,
      name: json['name'] as String?,
      quantity: json['quantity'] as int?,
      price: json['price'] as int?,
    );

Map<String, dynamic> _$CartProductModelToJson(CartProductModel instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'outContractNumber': instance.outContractNumber,
      'sellPlaceId': instance.sellPlaceId,
      'inProductId': instance.inProductId,
      'categoryName': instance.categoryName,
      'name': instance.name,
      'quantity': instance.quantity,
      'price': instance.price,
    };

PostProductModel _$PostProductModelFromJson(Map<String, dynamic> json) =>
    PostProductModel(
      productId: json['productId'] as int?,
      quantity: json['quantity'] as int?,
      price: json['price'] as int?,
    );

Map<String, dynamic> _$PostProductModelToJson(PostProductModel instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'quantity': instance.quantity,
      'price': instance.price,
    };

UnconfirmedProductsModel _$UnconfirmedProductsModelFromJson(
        Map<String, dynamic> json) =>
    UnconfirmedProductsModel(
      transactionId: json['transactionId'] as int?,
      status: json['status'] as int?,
      tradePlaceName: json['tradePlaceName'] as String?,
      date: json['date'] as String?,
      inConfirmed: json['inConfirmed'] as int?,
    );

Map<String, dynamic> _$UnconfirmedProductsModelToJson(
        UnconfirmedProductsModel instance) =>
    <String, dynamic>{
      'transactionId': instance.transactionId,
      'status': instance.status,
      'tradePlaceName': instance.tradePlaceName,
      'date': instance.date,
      'inConfirmed': instance.inConfirmed,
    };
