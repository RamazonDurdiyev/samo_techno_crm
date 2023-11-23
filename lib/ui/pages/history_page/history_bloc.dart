import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samo_techno_crm/models/history_model/history_model.dart';
import 'package:samo_techno_crm/repo/product_repo/product_repo.dart';
import 'package:samo_techno_crm/ui/pages/history_page/history_event.dart';
import 'package:samo_techno_crm/ui/pages/history_page/history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final ProductRepo repo;
  HistoryBloc({required this.repo}) : super(Initial()) {
    on<FetchHistoriesEvent>((event, emit) async {
      await _fetchHistories(emit);
    });
    on<FetchHistoriesByIdEvent>((event, emit) async {
      await _fetchHistoriesById(emit, event.id);
    });
  }

  // Data

  List<HistoryModel> histories = [];
  List<HistoryDetailModel> productsById = [];

  _fetchHistories(Emitter<HistoryState> emit) async {
    try {
      emit(FetchHistoriesState(state: State.loading));
      histories = await repo.fetchHistories();
      if (kDebugMode) {
        print("HistoryBloc _fetchHistories histories => $histories");
      }
      emit(FetchHistoriesState(state: State.loaded));
    } catch (e) {
      emit(FetchHistoriesState(state: State.error));
      if (kDebugMode) {
        print("HistoryBloc _fetchHistories error => $e");
      }
    }
  }

  _fetchHistoriesById(Emitter<HistoryState> emit, int id) async {
    try {
      emit(FetchHistoriesByIdState(state: State.loading));
      productsById = await repo.fetchHistoryProductById(id);
      if (kDebugMode) {
        print(
            "HistoryBloc _fetchHistoriesyById categoryById products => $productsById");
      }
      emit(FetchHistoriesByIdState(state: State.loaded));
    } catch (e) {
      emit(FetchHistoriesByIdState(state: State.error));
      if (kDebugMode) {
        print("HistoryBloc _fetchHistoriesById error => $e");
      }
    }
  }
}
