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
class PostProductInfoModel {
  final String? comment;
  final int? tradePlaceId;
  final List<Map<String,dynamic>>? products;

  PostProductInfoModel({
    this.comment,
    this.tradePlaceId,
    this.products,
  });

  factory PostProductInfoModel.fromJson(Map<String, dynamic> data) =>
      _$PostProductInfoModelFromJson(data);

  Map<String, dynamic> toJson() => _$PostProductInfoModelToJson(this);
}

@JsonSerializable()
class PostProductModel {
  final int? productId;
  final int? quantity;
  final double? price;

  PostProductModel({
    this.productId,
    this.quantity,
    this.price,
  });

  factory PostProductModel.fromJson(Map<String, dynamic> data) =>
      _$PostProductModelFromJson(data);

  Map<String, dynamic> toJson() => _$PostProductModelToJson(this);
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
