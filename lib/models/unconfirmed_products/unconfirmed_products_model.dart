import 'package:json_annotation/json_annotation.dart';
part 'unconfirmed_products_model.g.dart';

@JsonSerializable()
class UnconfirmedProductsModel {
  final int? transactionId;
  final String? fio;
  final String? tradePlace;
  final String? status;
  final String? createdDate;
  final String? tradeStatus;

  UnconfirmedProductsModel(
      {this.transactionId,
      this.fio,
      this.tradePlace,
      this.status,
      this.createdDate,
      this.tradeStatus});

  factory UnconfirmedProductsModel.fromJson(Map<String, dynamic> data) =>
      _$UnconfirmedProductsModelFromJson(data);

  Map<String, dynamic> toJson() => _$UnconfirmedProductsModelToJson(this);
}

@JsonSerializable()
class UnconfirmedByIdProductsModel {
  final int? id;
  final String? name;
  final double? price;
  final int? quantity;
  final String? date;

  UnconfirmedByIdProductsModel({
    this.id,
    this.name,
    this.price,
    this.quantity,
    this.date,
  });

  factory UnconfirmedByIdProductsModel.fromJson(Map<String, dynamic> data) =>
      _$UnconfirmedByIdProductsModelFromJson(data);

  Map<String, dynamic> toJson() => _$UnconfirmedByIdProductsModelToJson(this);
}