import 'package:json_annotation/json_annotation.dart';
part 'place_model.g.dart';

@JsonSerializable()
class PlaceModel{
  final int? id;
  final String? name;

  PlaceModel({this.id, this.name});

  factory PlaceModel.fromJson(Map<String, dynamic> data) =>
      _$PlaceModelFromJson(data);

  Map<String, dynamic> toJson() => _$PlaceModelToJson(this);
}