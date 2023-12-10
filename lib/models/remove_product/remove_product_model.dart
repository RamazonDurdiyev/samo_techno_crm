import 'package:json_annotation/json_annotation.dart';
part 'remove_product_model.g.dart';

@JsonSerializable()
class RProductModel {
  final int? id;
  final String? name;
  final String? imageUrl;
  final double? totalPrice;
  final int? totalNumber;
  final List<RProductItemModel>? children;

  RProductModel({
    this.id,
    this.name,
    this.imageUrl,
    this.totalPrice,
    this.totalNumber,
    this.children,
  });

  factory RProductModel.fromJson(Map<String, dynamic> data) =>
      _$RProductModelFromJson(data);

  Map<String, dynamic> toJson() => _$RProductModelToJson(this);
}

@JsonSerializable()
class RProductItemModel {
  final int? id;
  final String? name;
  final double? price;
  final int? quantity;
  final List<ProductPricesModel>? prices;

  RProductItemModel({
    this.id,
    this.name,
    this.price,
    this.quantity,
    this.prices,
  });

  factory RProductItemModel.fromJson(Map<String, dynamic> data) =>
      _$RProductItemModelFromJson(data);

  Map<String, dynamic> toJson() => _$RProductItemModelToJson(this);
}

@JsonSerializable()
class ProductPricesModel {
  final int? inproductId;
  final int? quantity;
  final double? price;

  ProductPricesModel({
    this.inproductId,
    this.quantity,
    this.price,
  });

  factory ProductPricesModel.fromJson(Map<String, dynamic> data) =>
      _$ProductPricesModelFromJson(data);

  Map<String, dynamic> toJson() => _$ProductPricesModelToJson(this);
}

@JsonSerializable()
class DeleteProductInfoModel {
  final int? placeId;
  final int? contractId;
  final List<Map<String,dynamic>>? products;

  DeleteProductInfoModel({
    this.placeId,
    this.contractId,
    this.products,
  });

  factory DeleteProductInfoModel.fromJson(Map<String, dynamic> data) =>
      _$DeleteProductInfoModelFromJson(data);

  Map<String, dynamic> toJson() => _$DeleteProductInfoModelToJson(this);
}

@JsonSerializable()
class DeleteProductModel {
  final int? productId;
  final int? inProductId;
  final int? quantity;
  final double? price;


  DeleteProductModel({
    this.productId,
    this.inProductId,
    this.quantity,
    this.price,
  });

  factory DeleteProductModel.fromJson(Map<String, dynamic> data) =>
      _$DeleteProductModelFromJson(data);

  Map<String, dynamic> toJson() => _$DeleteProductModelToJson(this);
}

@JsonSerializable()
class DeleteInProductModel {
  final int? inproductId;
  final int? quantity;
  final double? price;

  DeleteInProductModel({
    this.inproductId,
    this.quantity,
    this.price,
  });

  factory DeleteInProductModel.fromJson(Map<String, dynamic> data) =>
      _$DeleteInProductModelFromJson(data);

  Map<String, dynamic> toJson() => _$DeleteInProductModelToJson(this);
}