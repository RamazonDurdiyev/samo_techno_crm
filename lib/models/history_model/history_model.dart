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
  final int? id;
  final String? placeStatus;
  final String? status;
  final String? createdDate;
  final String? productName;
  final String? imageUrl;
  final int? quantity;
  final double? price;
  final String? address;

  HistoryItemModel({
    this.id,
    this.placeStatus,
    this.status,
    this.createdDate,
    this.productName,
    this.imageUrl,
    this.quantity,
    this.price,
    this.address,
  });

   factory HistoryItemModel.fromJson(Map<String, dynamic> data) =>
      _$HistoryItemModelFromJson(data);

  Map<String, dynamic> toJson() => _$HistoryItemModelToJson(this);
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

