import 'package:json_annotation/json_annotation.dart';
part 'unconfirmed_products_model.g.dart';

@JsonSerializable()
class UnconfirmedProductsModel {
  final int? transactionId;
  final int? status;
  final String? tradePlaceName;
  final String? date;
  final int? inConfirmed;

  UnconfirmedProductsModel(
      {this.transactionId,
      this.status,
      this.tradePlaceName,
      this.date,
      this.inConfirmed});

  factory UnconfirmedProductsModel.fromJson(Map<String, dynamic> data) =>
      _$UnconfirmedProductsModelFromJson(data);

  Map<String, dynamic> toJson() => _$UnconfirmedProductsModelToJson(this);
}