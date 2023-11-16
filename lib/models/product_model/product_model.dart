import 'package:json_annotation/json_annotation.dart';
part 'product_model.g.dart';

@JsonSerializable()
class ProductModel {
  final int? id;
  final String? name;
  final String? imageUrl;
  final List<ProductItemModel>? children;

  ProductModel({
    this.id,
    this.name,
    this.imageUrl,
    this.children,
  });

  factory ProductModel.fromJson(Map<String, dynamic> data) =>
      _$ProductModelFromJson(data);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}

@JsonSerializable()
class DeleteProductModel {
  final int? outContractNumber;
  final int? sellPlaceId;
  final int? inProductId;
  final int? quantity;

  DeleteProductModel({
    this.outContractNumber,
    this.sellPlaceId,
    this.inProductId,
    this.quantity,
  });

  factory DeleteProductModel.fromJson(Map<String, dynamic> data) =>
      _$DeleteProductModelFromJson(data);

  Map<String, dynamic> toJson() => _$DeleteProductModelToJson(this);
}

@JsonSerializable()
class RProductModel {
  final int? id;
  final String? name;
  int? totalPrice;
  int? totalNumber;
  final List<RProductItemModel>? children;

  RProductModel({
    this.id,
    this.name,
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

  final String? imageUrl;

  RProductItemModel({
    this.id,
    this.name,
    this.price,
    this.quantity,
    this.imageUrl,
  });

  factory RProductItemModel.fromJson(Map<String, dynamic> data) =>
      _$RProductItemModelFromJson(data);

  Map<String, dynamic> toJson() => _$RProductItemModelToJson(this);
}

@JsonSerializable()
class ProductItemModel {
  final int? id;
  final String? name;
  final String? imageUrl;

  ProductItemModel({
    this.id,
    this.name,
    this.imageUrl,
  });

  factory ProductItemModel.fromJson(Map<String, dynamic> data) =>
      _$ProductItemModelFromJson(data);

  Map<String, dynamic> toJson() => _$ProductItemModelToJson(this);
}

@JsonSerializable()
class CartProductModel {
  final int? productId;
  final int? outContractNumber;
  final int? sellPlaceId;
  final int? inProductId;
  final String? categoryName;
  final String? name;
  final int? quantity;
  final int? price;

  CartProductModel({
    this.productId,
    this.outContractNumber,
    this.sellPlaceId,
    this.inProductId,
    this.categoryName,
    this.name,
    this.quantity,
    this.price,
  });

  factory CartProductModel.fromJson(Map<String, dynamic> data) =>
      _$CartProductModelFromJson(data);

  Map<String, dynamic> toJson() => _$CartProductModelToJson(this);
}

@JsonSerializable()
class PostProductModel {
  final int? productId;
  final int? quantity;
  final int? price;

  PostProductModel({
    this.productId,
    this.quantity,
    this.price,
  });

  factory PostProductModel.fromJson(Map<String, dynamic> data) =>
      _$PostProductModelFromJson(data);

  Map<String, dynamic> toJson() => _$PostProductModelToJson(this);
}

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

// @JsonSerializable()
// class UnconfirmedProductsItemModel {
//   final int? transactionId;
//   final int? status;
//   final String? tradePlaceName;
//   final String? date;
//   final int? inConfirmed;

//   UnconfirmedProductsItemModel(
//       {this.transactionId,
//       this.status,
//       this.tradePlaceName,
//       this.date,
//       this.inConfirmed});

//   factory UnconfirmedProductsItemModel.fromJson(Map<String, dynamic> data) =>
//       _$UnconfirmedProductsItemModelFromJson(data);

//   Map<String, dynamic> toJson() => _$UnconfirmedProductsItemModelToJson(this);
// }

// @JsonSerializable()
// class UnconfirmedProductsModel {
//   final int? transactionId;
//   final int? status;
//   final String? tradePlaceName;
//   final String? date;
//   final int? inConfirmed;

//   UnconfirmedProductsModel(
//       {this.transactionId,
//       this.status,
//       this.tradePlaceName,
//       this.date,
//       this.inConfirmed});

//   factory UnconfirmedProductsModel.fromJson(Map<String, dynamic> data) =>
//       _$UnconfirmedProductsModelFromJson(data);

//   Map<String, dynamic> toJson() => _$UnconfirmedProductsModelToJson(this);
// }
