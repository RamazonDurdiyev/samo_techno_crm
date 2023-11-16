import 'package:equatable/equatable.dart';

abstract class SignInState extends Equatable{}

class Initial extends SignInState{
  @override
 
  List<Object?> get props => [];
}

class LoginState extends SignInState{
  final State state;

  LoginState({required this.state});
  @override
  List<Object?> get props => [state];
}

enum State {initial,loading,loaded,error}