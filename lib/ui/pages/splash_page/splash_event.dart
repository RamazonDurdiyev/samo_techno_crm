import 'package:equatable/equatable.dart';

abstract class SplashEvent extends Equatable {}

class CheckUserEvent extends SplashEvent {
  @override
  List<Object?> get props => [];
}
