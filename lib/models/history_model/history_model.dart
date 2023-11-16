import 'package:json_annotation/json_annotation.dart';
part 'history_model.g.dart';

@JsonSerializable()
class HistoryModel {
  final int? transactionId;
  final int? status;
  final String? tradePlaceName;
  final String? date;
  final int? userId;

  HistoryModel({
    this.transactionId,
    this.status,
    this.tradePlaceName,
    this.date,
    this.userId,
  });

   factory HistoryModel.fromJson(Map<String, dynamic> data) =>
      _$HistoryModelFromJson(data);

  Map<String, dynamic> toJson() => _$HistoryModelToJson(this);
}


@JsonSerializable()
class HistoryDetailModel {
  final int? addedUserId;
  final String? addedDate;
  final int? status;
  final int? isConfirmed;
  final List? products;

  HistoryDetailModel({
    this.addedUserId,
    this.addedDate,
    this.status,
    this.isConfirmed,
    this.products,
  });

   factory HistoryDetailModel.fromJson(Map<String, dynamic> data) =>
      _$HistoryDetailModelFromJson(data);

  Map<String, dynamic> toJson() => _$HistoryDetailModelToJson(this);
}


@JsonSerializable()
class HistoryDetailProductModel {
  final String? name;
  final String? imageUrl;
  final double? price;
  final int? quantity;
  final String? date;

  HistoryDetailProductModel({
    this.name,
    this.imageUrl,
    this.price,
    this.quantity,
    this.date,
  });

   factory HistoryDetailProductModel.fromJson(Map<String, dynamic> data) =>
      _$HistoryDetailProductModelFromJson(data);

  Map<String, dynamic> toJson() => _$HistoryDetailProductModelToJson(this);
}

