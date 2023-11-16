// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryModel _$HistoryModelFromJson(Map<String, dynamic> json) => HistoryModel(
      transactionId: json['transactionId'] as int?,
      status: json['status'] as int?,
      tradePlaceName: json['tradePlaceName'] as String?,
      date: json['date'] as String?,
      userId: json['userId'] as int?,
    );

Map<String, dynamic> _$HistoryModelToJson(HistoryModel instance) =>
    <String, dynamic>{
      'transactionId': instance.transactionId,
      'status': instance.status,
      'tradePlaceName': instance.tradePlaceName,
      'date': instance.date,
      'userId': instance.userId,
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
