import 'package:equatable/equatable.dart';

abstract class SignInEvent extends Equatable{}

class LoginEvent extends SignInEvent{
  @override
  List<Object?> get props => [];
}