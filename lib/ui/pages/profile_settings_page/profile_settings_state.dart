import 'package:equatable/equatable.dart';

abstract class ProfileSettingsState extends Equatable {}

class Initial extends ProfileSettingsState {
  @override
  List<Object?> get props => [];
}

class PickImageState extends ProfileSettingsState {
  final State state;

  PickImageState({required this.state});
  @override
  List<Object?> get props => [state];
}

enum State { initial, loading, loaded, error }
