import 'package:json_annotation/json_annotation.dart';
part 'category_model.g.dart';

@JsonSerializable()
class CategoryModel {
  final int? id;
  final String? name;
  final String? imageUrl;
  @JsonKey(name: 'children')
  final List<CategoryItemModel>? categoryItems;

  CategoryModel({
    this.id,
    this.name,
    this.imageUrl,
    this.categoryItems,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> data) =>
      _$CategoryModelFromJson(data);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}

@JsonSerializable()
class CategoryItemModel {
  final int? id;
  final String? name;
  final String? imageUrl;

  CategoryItemModel({
    this.id,
    this.name,
    this.imageUrl,
  });

  factory CategoryItemModel.fromJson(Map<String, dynamic> data) =>
      _$CategoryItemModelFromJson(data);

  Map<String, dynamic> toJson() => _$CategoryItemModelToJson(this);
}