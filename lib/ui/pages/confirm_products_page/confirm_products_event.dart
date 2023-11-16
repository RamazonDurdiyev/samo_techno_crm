import 'package:equatable/equatable.dart';

abstract class ConfirmProductsEvent extends Equatable {}

class FetchUnconfirmedsEvent extends ConfirmProductsEvent {
  @override
  List<Object?> get props => [];
}
