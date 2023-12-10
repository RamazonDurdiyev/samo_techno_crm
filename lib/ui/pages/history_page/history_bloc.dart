import 'package:flutter/material.dart' hide State;
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
    on<FilterChangeIsSellEvent>((event, emit) async {
      await _changeIsSell(emit);
    });
    on<FetchMoreEvent>((event, emit) async {
      await _fetchMore(emit);
    });
  }

  // Controllers

  ScrollController scrlController = ScrollController();

  // Data

  HistoryModel histories = HistoryModel();
  List<HistoryItemModel> historyItems = [];
  HistoryDetailModel historyDetail = HistoryDetailModel();
  List<HistoryDetailProductModel> historyDetailProducts = [];
  bool isSell = false;
  int page = 0;
  String date = "";

  _fetchHistories(Emitter<HistoryState> emit) async {
    try {
      emit(FetchHistoriesState(state: State.loading));
      histories =
          await repo.fetchHistories(isSell ? "SELL" : "BUY", page,);
      historyItems = histories.data ?? [];
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
      historyDetail = await repo.fetchHistoryProductById(
        id,
        isSell ? "SELL" : "BUY",
      );
      historyDetailProducts = historyDetail.products ?? [];
      if (kDebugMode) {
        print(
            "HistoryBloc _fetchHistoriesyById categoryById products => $historyDetail");
      }
      emit(FetchHistoriesByIdState(state: State.loaded));
    } catch (e) {
      emit(FetchHistoriesByIdState(state: State.error));
      if (kDebugMode) {
        print("HistoryBloc _fetchHistoriesById error => $e");
      }
    }
  }

  _changeIsSell(Emitter<HistoryState> emit) {
    try {
      emit(FilterChangeIsSellState(state: State.loading));
      isSell = !isSell;
      historyItems = [];
      emit(FilterChangeIsSellState(state: State.loaded));
    } catch (e) {
      emit(FilterChangeIsSellState(state: State.error));
    }
  }

  _fetchMore(Emitter<HistoryState> emit,) async {
    try {
      emit(FetchMoreState(state: State.loading));
      page++;
      await repo
          .fetchHistories(isSell ? "SELL" : "BUY", page,)
          .then((value) {
        historyItems.addAll(value.data ?? []);
        scrlController.removeListener(() {});
      });

      emit(FetchMoreState(state: State.loaded));
    } catch (e) {
      emit(FetchMoreState(state: State.error));
    }
  }
}
