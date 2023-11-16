import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samo_techno_crm/ui/pages/statistics_page/statistics_event.dart';
import 'package:samo_techno_crm/ui/pages/statistics_page/statistics_state.dart';

class StatisticsBloc extends Bloc<StatisticsEvent, StatisticsState> {
  StatisticsBloc() : super(Initial()) {
    on<ChangeStatisticsTabEvent>((event, emit) async {
      await _changeTabEvent(emit, event.value);
    });
  }

  // Data

  int currentIndexOfTab = 0;


  _changeTabEvent(Emitter<StatisticsState> emit, int value) {
    try {
      emit(ChangeStatisticsTabState(state: State.loading));
      currentIndexOfTab = value;
      emit(ChangeStatisticsTabState(state: State.loaded));
    } catch (e) {
      emit(ChangeStatisticsTabState(state: State.error));
    }
  }
}
