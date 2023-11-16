import 'package:equatable/equatable.dart';

abstract class HistoryEvent extends Equatable{}

class FetchHistoriesEvent extends HistoryEvent{
  @override
  List<Object?> get props => [];
}

class FetchHistoriesByIdEvent extends HistoryEvent {
  final int id;

  FetchHistoriesByIdEvent({required this.id});
  @override
  List<Object?> get props => [id];
}