import 'package:equatable/equatable.dart';

abstract class SplashState extends Equatable {}

class Initial extends SplashState {
  @override
  List<Object?> get props => [];
}

class CheckUserState extends SplashState {
  final State state;

  CheckUserState({required this.state});
  @override
  List<Object?> get props => [state];
}

enum State { initial, loading, loaded, error }
