import 'package:equatable/equatable.dart';

abstract class ConfirmProductsEvent extends Equatable {}

class FetchUnconfirmedsEvent extends ConfirmProductsEvent {
  @override
  List<Object?> get props => [];
}

class FetchUnconfirmedByIdEvent extends ConfirmProductsEvent {
  final int transactionId;
  final String status;
  FetchUnconfirmedByIdEvent({required this.transactionId, required this.status});
  @override
  List<Object?> get props => [transactionId, status];
}
