import 'package:json_annotation/json_annotation.dart';
part 'cart_product_model.g.dart';

@JsonSerializable()
class CartProductModel {
  final int? productId;
  final String? name;
  final String? categoryName;
  final int? inProductId;
  final int? quantity;
  final double? price;

  CartProductModel({
    this.productId,
    this.name,
    this.categoryName,
    this.inProductId,
    this.quantity,
    this.price,
  });

  factory CartProductModel.fromJson(Map<String, dynamic> data) =>
      _$CartProductModelFromJson(data);

  Map<String, dynamic> toJson() => _$CartProductModelToJson(this);
}

@JsonSerializable()
class CartInProductModel {
  final int? inproductId;
  final int? quantity;
  final double? price;

  CartInProductModel({
    this.inproductId,
    this.quantity,
    this.price,
  });

  factory CartInProductModel.fromJson(Map<String, dynamic> data) =>
      _$CartInProductModelFromJson(data);

  Map<String, dynamic> toJson() => _$CartInProductModelToJson(this);
}