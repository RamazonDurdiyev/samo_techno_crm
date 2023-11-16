import 'package:equatable/equatable.dart';

abstract class ProfileSettingsEvent extends Equatable{}

class PickImageEvent extends ProfileSettingsEvent{
  @override
  List<Object?> get props => [];
}