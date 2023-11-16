import 'package:equatable/equatable.dart';

abstract class HistoryState extends Equatable {}

class Initial extends HistoryState {
  @override
  List<Object?> get props => [];
}

class FetchHistoriesState extends HistoryState {
  final State state;

  FetchHistoriesState({required this.state});
  @override
  List<Object?> get props => [state];
}

class FetchHistoriesByIdState extends HistoryState {
  final State state;

  FetchHistoriesByIdState({required this.state});

  @override
  List<Object?> get props => [state];
}

enum State { initial, loading, loaded, error }
