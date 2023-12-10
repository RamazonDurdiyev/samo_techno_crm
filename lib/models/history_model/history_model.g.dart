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
      transactionId: json['transactionId'] as int?,
      fio: json['fio'] as String?,
      tradePlace: json['tradePlace'] as String?,
      status: json['status'] as String?,
      createdDate: json['createdDate'] as String?,
      placeStatus: json['placeStatus'] as String?,
    );

Map<String, dynamic> _$HistoryItemModelToJson(HistoryItemModel instance) =>
    <String, dynamic>{
      'transactionId': instance.transactionId,
      'fio': instance.fio,
      'tradePlace': instance.tradePlace,
      'status': instance.status,
      'createdDate': instance.createdDate,
      'placeStatus': instance.placeStatus,
    };

HistoryDetailModel _$HistoryDetailModelFromJson(Map<String, dynamic> json) =>
    HistoryDetailModel(
      addedPersonName: json['addedPersonName'] as String?,
      addedDate: json['addedDate'] as String?,
      checkedPerson: json['checkedPerson'] as String?,
      checkedDate: json['checkedDate'] as String?,
      status: json['status'] as String?,
      comment: json['comment'] as String?,
      products: (json['products'] as List<dynamic>?)
          ?.map((e) =>
              HistoryDetailProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HistoryDetailModelToJson(HistoryDetailModel instance) =>
    <String, dynamic>{
      'addedPersonName': instance.addedPersonName,
      'addedDate': instance.addedDate,
      'checkedPerson': instance.checkedPerson,
      'checkedDate': instance.checkedDate,
      'status': instance.status,
      'comment': instance.comment,
      'products': instance.products,
    };

HistoryDetailProductModel _$HistoryDetailProductModelFromJson(
        Map<String, dynamic> json) =>
    HistoryDetailProductModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      quantity: json['quantity'] as int?,
      date: json['date'] as String?,
    );

Map<String, dynamic> _$HistoryDetailProductModelToJson(
        HistoryDetailProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'quantity': instance.quantity,
      'date': instance.date,
    };
