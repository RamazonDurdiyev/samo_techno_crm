import 'package:equatable/equatable.dart';

abstract class StatisticsState extends Equatable{}

class Initial extends StatisticsState{
  @override
  List<Object?> get props => [];
}

class ChangeStatisticsTabState extends StatisticsState{
  final State state;

  ChangeStatisticsTabState({required this.state});
  @override
  List<Object?> get props => [state];
}

enum State{initial,loading,loaded,error}