import 'package:equatable/equatable.dart';

abstract class StatisticsEvent extends Equatable{}

class ChangeStatisticsTabEvent extends StatisticsEvent{
  final int value;

  ChangeStatisticsTabEvent({required this.value});
  @override
  List<Object?> get props => [value];
}