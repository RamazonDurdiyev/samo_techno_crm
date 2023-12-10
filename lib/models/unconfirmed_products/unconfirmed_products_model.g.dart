// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unconfirmed_products_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
