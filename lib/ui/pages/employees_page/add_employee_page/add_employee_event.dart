import 'package:equatable/equatable.dart';

abstract class AddEmployeeEvent extends Equatable {}

class PostUserEvent extends AddEmployeeEvent {
  @override
  List<Object?> get props => [];
}
