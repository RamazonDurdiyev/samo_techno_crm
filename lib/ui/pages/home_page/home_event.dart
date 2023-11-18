import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable{}

class RemoveUserEvent extends HomeEvent{
  @override
  List<Object?> get props => [];
}