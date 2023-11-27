// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryModel _$HistoryModelFromJson(Map<String, dynamic> json) => HistoryModel(
      page: json['page'] as int?,
      size: json['size'] as int?,
      totalPage: json['totalPage'] as int?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => HistoryItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HistoryModelToJson(HistoryModel instance) =>
    <String, dynamic>{
      'page': instance.page,
      'size': instance.size,
      'totalPage': instance.totalPage,
      'data': instance.data,
    };

HistoryItemModel _$HistoryItemModelFromJson(Map<String, dynamic> json) =>
    HistoryItemModel(
      id: json['id'] as int?,
      placeStatus: json['placeStatus'] as String?,
      status: json['status'] as String?,
      createdDate: json['createdDate'] as String?,
      productName: json['productName'] as String?,
      imageUrl: json['imageUrl'] as String?,
      quantity: json['quantity'] as int?,
      price: (json['price'] as num?)?.toDouble(),
      address: json['address'] as String?,
    );

Map<String, dynamic> _$HistoryItemModelToJson(HistoryItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'placeStatus': instance.placeStatus,
      'status': instance.status,
      'createdDate': instance.createdDate,
      'productName': instance.productName,
      'imageUrl': instance.imageUrl,
      'quantity': instance.quantity,
      'price': instance.price,
      'address': instance.address,
    };

HistoryDetailModel _$HistoryDetailModelFromJson(Map<String, dynamic> json) =>
    HistoryDetailModel(
      addedUserId: json['addedUserId'] as int?,
      addedDate: json['addedDate'] as String?,
      status: json['status'] as int?,
      isConfirmed: json['isConfirmed'] as int?,
      products: json['products'] as List<dynamic>?,
    );

Map<String, dynamic> _$HistoryDetailModelToJson(HistoryDetailModel instance) =>
    <String, dynamic>{
      'addedUserId': instance.addedUserId,
      'addedDate': instance.addedDate,
      'status': instance.status,
      'isConfirmed': instance.isConfirmed,
      'products': instance.products,
    };

HistoryDetailProductModel _$HistoryDetailProductModelFromJson(
        Map<String, dynamic> json) =>
    HistoryDetailProductModel(
      name: json['name'] as String?,
      imageUrl: json['imageUrl'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      quantity: json['quantity'] as int?,
      date: json['date'] as String?,
    );

Map<String, dynamic> _$HistoryDetailProductModelToJson(
        HistoryDetailProductModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'price': instance.price,
      'quantity': instance.quantity,
      'date': instance.date,
    };
