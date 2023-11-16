import 'package:equatable/equatable.dart';

abstract class SearchAddressEvent extends Equatable{}

class ShowToastEvent extends SearchAddressEvent{
  @override
  List<Object?> get props => [];
}