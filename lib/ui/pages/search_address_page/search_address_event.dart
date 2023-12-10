import 'package:equatable/equatable.dart';
import 'package:samo_techno_crm/models/place_model/place_model.dart';

abstract class SearchAddressEvent extends Equatable{}

class ShowToastEvent extends SearchAddressEvent{
  @override
  List<Object?> get props => [];
}

class GetAllPlacesEvent extends SearchAddressEvent{
  final String status;

  GetAllPlacesEvent({required this.status});
  @override
  List<Object?> get props => [status];
}

class SelectAddressEvent extends SearchAddressEvent{
  final PlaceModel place;
  final bool isSell;

  SelectAddressEvent({required this.place,required this.isSell});
  @override
  List<Object?> get props => [place,isSell];
}

class SearchPlaceEvent extends SearchAddressEvent{
  final String status;
  final String name;

  SearchPlaceEvent({required this.status,required this.name});
  @override
  List<Object?> get props => [status,name];
}