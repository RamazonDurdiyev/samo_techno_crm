import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samo_techno_crm/models/unconfirmed_products/unconfirmed_products_model.dart';
import 'package:samo_techno_crm/repo/product_repo/product_repo.dart';
import 'package:samo_techno_crm/ui/pages/confirm_products_page/confirm_products_event.dart';
import 'package:samo_techno_crm/ui/pages/confirm_products_page/confirm_products_state.dart';

class ConfirmProductsBloc extends Bloc<ConfirmProductsEvent,ConfirmProductsState>{
  final ProductRepo repo;
  ConfirmProductsBloc({required this.repo}):super(Initial()){
    on<FetchUnconfirmedsEvent>((event, emit)async{
      await _fetchUnconfirmeds(emit);
    });
    on<FetchUnconfirmedByIdEvent>((event, emit) async{
      await _fetchUnconfirmedsById(emit,event.status,event.transactionId);
    });
  }

  // Data

  List<UnconfirmedProductsModel> unconfirmeds = [];
  List<UnconfirmedByIdProductsModel> detailedUnconfirmeds = [];
  
  _fetchUnconfirmeds(Emitter<ConfirmProductsState> emit) async{
    try {
      emit(FetchUnconfirmedsState(state: State.loading));
      unconfirmeds = await repo.fetchUnconfirmeds();
      emit(FetchUnconfirmedsState(state: State.loaded));
    } catch (e) {
      emit(FetchUnconfirmedsState(state: State.error));
      if (kDebugMode) {
        print("ConfirmProductsBloc _fetchUnconfirmeds error => $e");
      }
    }
  }
  
  _fetchUnconfirmedsById(Emitter<ConfirmProductsState> emit, String status, int transactionId)async{
    try {
      emit(FetchUnconfirmedByIdState(state: State.loading));
      detailedUnconfirmeds = await repo.fetchUnconfirmedById(status, transactionId);
      if (kDebugMode) {
        print("ConfirmProductsBloc _fetchUnconfirmedsById detailedUnconfirmeds => $detailedUnconfirmeds");
      }
      emit(FetchUnconfirmedByIdState(state: State.loaded));
    } catch (e) {
      if (kDebugMode) {
        print("ConfirmProductsBloc _fetchUnconfirmedsById error => $e");
      }
      emit(FetchUnconfirmedByIdState(state: State.error));
    }
  }

}