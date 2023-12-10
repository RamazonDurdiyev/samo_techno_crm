// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unconfirmed_products_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnconfirmedProductsModel _$UnconfirmedProductsModelFromJson(
        Map<String, dynamic> json) =>
    UnconfirmedProductsModel(
      transactionId: json['transactionId'] as int?,
      fio: json['fio'] as String?,
      tradePlace: json['tradePlace'] as String?,
      status: json['status'] as String?,
      createdDate: json['createdDate'] as String?,
      tradeStatus: json['tradeStatus'] as String?,
    );

Map<String, dynamic> _$UnconfirmedProductsModelToJson(
        UnconfirmedProductsModel instance) =>
    <String, dynamic>{
      'transactionId': instance.transactionId,
      'fio': instance.fio,
      'tradePlace': instance.tradePlace,
      'status': instance.status,
      'createdDate': instance.createdDate,
      'tradeStatus': instance.tradeStatus,
    };

UnconfirmedByIdProductsModel _$UnconfirmedByIdProductsModelFromJson(
        Map<String, dynamic> json) =>
    UnconfirmedByIdProductsModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      quantity: json['quantity'] as int?,
      date: json['date'] as String?,
    );

Map<String, dynamic> _$UnconfirmedByIdProductsModelToJson(
        UnconfirmedByIdProductsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'quantity': instance.quantity,
      'date': instance.date,
    };
