import 'package:json_annotation/json_annotation.dart';
part 'history_model.g.dart';

@JsonSerializable()
class HistoryModel {
  final int? page;
  final int? size;
  final int? totalPage;
  final List<HistoryItemModel>? data;

  HistoryModel({
    this.page,
    this.size,
    this.totalPage,
    this.data,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> data) =>
      _$HistoryModelFromJson(data);

  Map<String, dynamic> toJson() => _$HistoryModelToJson(this);
}

@JsonSerializable()
class HistoryItemModel {
  final int? transactionId;
  final String? fio;
  final String? tradePlace;
  final String? status;
  final String? createdDate;
  final String? placeStatus;

  HistoryItemModel({
    this.transactionId,
    this.fio,
    this.tradePlace,
    this.status,
    this.createdDate,
    this.placeStatus,
  });

  factory HistoryItemModel.fromJson(Map<String, dynamic> data) =>
      _$HistoryItemModelFromJson(data);

  Map<String, dynamic> toJson() => _$HistoryItemModelToJson(this);
}

@JsonSerializable()
class HistoryDetailModel {
  final String? addedPersonName;
  final String? addedDate;
  final String? checkedPerson;
  final String? checkedDate;
  final String? status;
  final String? comment;
  final List<HistoryDetailProductModel>? products;

  factory HistoryDetailModel.fromJson(Map<String, dynamic> data) =>
      _$HistoryDetailModelFromJson(data);

  HistoryDetailModel(
      {this.addedPersonName,
      this.addedDate,
      this.checkedPerson,
      this.checkedDate,
      this.status,
      this.comment,
      this.products});

  Map<String, dynamic> toJson() => _$HistoryDetailModelToJson(this);
}

@JsonSerializable()
class HistoryDetailProductModel {
  final int? id;
  final String? name;
  final double? price;
  final int? quantity;
  final String? date;

  HistoryDetailProductModel({
    this.id,
    this.name,
    this.price,
    this.quantity,
    this.date,
  });

  factory HistoryDetailProductModel.fromJson(Map<String, dynamic> data) =>
      _$HistoryDetailProductModelFromJson(data);

  Map<String, dynamic> toJson() => _$HistoryDetailProductModelToJson(this);
}
