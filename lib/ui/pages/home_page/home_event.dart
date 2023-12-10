import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class HomeEvent extends Equatable{}

class RemoveUserEvent extends HomeEvent{
  @override
  List<Object?> get props => [];
}

class CheckAddressSelectedEvent extends HomeEvent{
  @override
  List<Object?> get props => [UniqueKey()];
}

class RemoveAddressEvent extends HomeEvent{
  @override
  List<Object?> get props => [];
}